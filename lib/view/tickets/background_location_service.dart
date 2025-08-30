import 'dart:async';
import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart' as Location;
import 'package:nb_utils/nb_utils.dart'; // Assuming nb_utils is still needed for extensions
import 'package:permission_handler/permission_handler.dart';
import 'package:ticky/initialization.dart'; // For localNotifications instance
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/utils/config.dart';
import 'package:ticky/utils/geo_services/geo_functions.dart';

// Assuming ticketStartWorkStore is a global instance or accessible
// Make sure this is initialized before BackgroundLocationService is used.

class BackgroundLocationService {
  static final BackgroundLocationService _instance = BackgroundLocationService._internal();

  factory BackgroundLocationService() {
    return _instance;
  }

  BackgroundLocationService._internal();

  final Location.Location _location = Location.Location();
  StreamSubscription<Location.LocationData>? _locationSubscription;
  TicketData? _currentlyTrackedTicket; // Stores the ticket data being tracked
  bool _isTrackingActive = false; // New flag to indicate if tracking is active
  Timer? _apiCallDebounceTimer; // Timer for debouncing API calls

  // A getter to check if tracking is active for a specific ticket
  bool isTrackingTicket(int ticketId) {
    return _isTrackingActive && _currentlyTrackedTicket?.id == ticketId;
  }

  Future<void> initLocationService() async {
    // Step 1: Check if location service is enabled
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        log('❌ Location services are not enabled.');
        return;
      }
    }

    // Step 2: Check and request 'WhenInUse' permission
    Location.PermissionStatus permissionStatus = await _location.hasPermission();
    if (permissionStatus == Location.PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
    }

    // Step 3: Ensure 'WhenInUse' is granted before requesting 'Always'
    if (permissionStatus == Location.PermissionStatus.granted || permissionStatus == Location.PermissionStatus.grantedLimited) {
      // Use permission_handler to request 'Always' permission
      log("Use permission_handler to request 'Always' permission");
      PermissionStatus alwaysStatus = await Permission.locationAlways.request();

      if (alwaysStatus.isGranted) {
        log('✅ Location Always permission granted.');
      } else {
        log('⚠️ Location Always permission NOT granted.');
      }
    } else {
      log('❌ Location WhenInUse permission not granted.');
    }

    log('✅ Location service and permission initialized.');
  }

  Future<void> _enableBackgroundMode() async {
    bool isEnabled = await _location.enableBackgroundMode(enable: true);
    if (isEnabled) {
      log('✅ Background location mode enabled.');
    } else {
      log('❌ Failed to enable background location mode.');
    }
  }

  Future<void> disableBackgroundMode() async {
    bool isDisabled = await _location.enableBackgroundMode(enable: false);
    if (!isDisabled) {
      log('❌ Failed to disable background location mode.');
    } else {
      await _locationSubscription?.cancel();
      _locationSubscription = null; // Clear the subscription
      _isTrackingActive = false; // Set tracking to inactive
      _apiCallDebounceTimer?.cancel(); // Cancel any pending API call
      _apiCallDebounceTimer = null;
      log('✅ Background location mode disabled.');
    }
  }

  /// Starts background location tracking for a given ticket.
  /// Call this when a ticket moves to an "in-progress" status.
  Future<void> startTracking(TicketData ticketData) async {
    // If we are already tracking this specific ticket, do nothing.
    if (_isTrackingActive && _currentlyTrackedTicket?.id == ticketData.id) {
      log('Background tracking already active for ticket ID: ${ticketData.id}. Skipping restart.');
      return;
    }

    // If tracking another ticket, stop it first.
    if (_isTrackingActive && _currentlyTrackedTicket?.id != ticketData.id) {
      log('Switching tracking from ticket ID: ${_currentlyTrackedTicket?.id} to ${ticketData.id}. Stopping old tracking.');
      await stopTracking();
    }

    log('Starting background tracking for ticket ID: ${ticketData.id}');
    _currentlyTrackedTicket = ticketData;
    _isTrackingActive = true;
    await _enableBackgroundMode();

    _locationSubscription = _location.onLocationChanged.listen(
      (event) async {
        if (_currentlyTrackedTicket == null) {
          log('No ticket data set for tracking. Stopping.');
          await stopTracking();
          return;
        }

        final double ticketLat = _currentlyTrackedTicket!.ticketLat.toDouble();
        final double ticketLng = _currentlyTrackedTicket!.ticketLng.toDouble();

        double distance = await calculateDistance(
          event.latitude ?? 0.0,
          event.longitude ?? 0.0,
          ticketLat,
          ticketLng,
        );

        log("onLocationChanged => Distance: $distance meters");

        int roundedDistance;
        if (distance < 1000) {
          roundedDistance = distance.round().toInt();
        } else {
          roundedDistance = (distance / 1000).round().toInt(); // Convert KM to rounded meters
        }

        bool isWithinRange = distance <= Config.allowedWorkRange;
        log("Checking distance: $distance, isWithinRange: $isWithinRange (Allowed: ${Config.allowedWorkRange} meters)");

        // Debounce the API call to get the latest ticket status
        _apiCallDebounceTimer?.cancel(); // Cancel previous timer if it exists
        _apiCallDebounceTimer = Timer(const Duration(minutes: 1), () async {
          // Call API every 1 minute
          log('Debounced: Fetching latest ticket data for ID: ${_currentlyTrackedTicket!.id}');
          await ticketStartWorkStore.handleTicketFuture(
            ticketId: _currentlyTrackedTicket!.id.validate(),
            startLatitude: event.latitude,
            startLongitude: event.longitude,
          );
          TicketData? latestTicketData = ticketStartWorkStore.ticketWorkResponse?.ticketData;

          if (latestTicketData == null) {
            log('Latest ticket data is null. Cannot proceed with status check. Stopping tracking.');
            await stopTracking();
            return;
          }

          // Important: Re-evaluate state based on latest data
          if (!latestTicketData.isProgress()) {
            log('Ticket is no longer in progress (status: ${latestTicketData.ticketStatus}). Stopping background tracking.');
            await stopTracking();
            return;
          }

          if (!isWithinRange && !latestTicketData.isBreak()) {
            log('Out of range and not on break. Initiating auto break for ticket ID: ${latestTicketData.id}.');
            if (latestTicketData.ticketWorks.validate().isNotEmpty) {
              await ticketStartWorkStore.addBreak(data: latestTicketData.ticketWorks.validate().reversed.first);
              await ticketStartWorkStore.refreshTicketDetails(ticketId: latestTicketData.id.validate());
              await disableBackgroundMode(); // Disable after auto break
              localNotificationOnAutoBreak(ticketId: latestTicketData.id ?? -1000);
            } else {
              log('No existing work entry to add a break to.');
            }
          }
        });
      },
      onError: (e) {
        log('Error in location stream: $e');
        // Optionally stop tracking on severe errors
        stopTracking();
      },
      cancelOnError: true, // Cancel subscription on error
    );
    log('✅ Background location tracking successfully initiated for ticket ID: ${_currentlyTrackedTicket!.id}');
  }

  // --- MODIFIED: stopTracking() ---
  /// Stops background location tracking.
  /// Call this when a ticket is held, closed, or completed.
  Future<void> stopTracking() async {
    // Add an early exit if already inactive according to our internal state
    if (!_isTrackingActive) {
      log('stopTracking called but internal state is already inactive. Skipping.');
      return;
    }

    log('Attempting to stop background tracking.');
    await disableBackgroundMode(); // This will now correctly handle the _isTrackingActive flag and cleanup
    log('✅ Background location tracking successfully commanded to stop.');
  }

  void localNotificationOnAutoBreak({required int ticketId}) async {
    Map<String, dynamic> _localNotificationPayload = {};

    _localNotificationPayload = {
      "title": "Break From Ticket",
      "content": "Ticket ID #$ticketId is on break because of out of distance from Work Address",
      "break": true,
      "ticketId": ticketId,
    };

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'Channel for important notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker', // Optional, for older Android versions
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await localNotifications.show(
      0, // Notification ID
      _localNotificationPayload['title'],
      _localNotificationPayload['content'],
      notificationDetails,
      payload: jsonEncode(
        _localNotificationPayload,
      ),
    );
  }
}

// Global instance to be accessible throughout the app
final BackgroundLocationService backgroundLocationService = BackgroundLocationService();
