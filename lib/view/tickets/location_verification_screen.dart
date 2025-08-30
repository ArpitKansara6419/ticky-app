import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/utils/config.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/geo_services/geo_functions.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';

class LocationVerificationScreen extends StatefulWidget {
  final String workAddress;
  final int ticketId;
  final void Function() onLocationVerifiedSuccessfully;
  final TicketData ticketData;

  const LocationVerificationScreen({
    Key? key,
    required this.workAddress,
    required this.ticketId,
    required this.onLocationVerifiedSuccessfully,
    required this.ticketData,
  }) : super(key: key);

  @override
  _LocationVerificationScreenState createState() => _LocationVerificationScreenState();
}

class _LocationVerificationScreenState extends State<LocationVerificationScreen> {
  GoogleMapController? _mapController;
  StreamSubscription<LocationData>? _locationSubscription;

  LocationData? currentPosition;
  bool isWithinRange = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _startLocationTracking();
  }

  void _startLocationTracking() async {
    setState(() => isLoading = true);

    final double taskLat = widget.ticketData.ticketLat.validate().toDouble();
    final double taskLng = widget.ticketData.ticketLng.validate().toDouble();
    final LatLng taskLocation = LatLng(taskLat, taskLng);
    currentPosition = await Location().getLocation();
    if (currentPosition != null) {
      buildingProcess(
        locationData: currentPosition!,
        taskLocation: taskLocation,
        taskLat: taskLat,
        taskLng: taskLng,
      );
    }
    _locationSubscription = Location().onLocationChanged.listen((event) async {
      buildingProcess(
        locationData: event,
        taskLocation: taskLocation,
        taskLat: taskLat,
        taskLng: taskLng,
        assignToCurrentPosition: true,
      );
    });
  }

  void _fitBounds({required LatLng currentLocation, required LatLng taskLocation}) {
    if (_mapController != null) {
      final bounds = LatLngBounds(
        southwest: LatLng(min(currentLocation.latitude, taskLocation.latitude), min(currentLocation.longitude, taskLocation.longitude)),
        northeast: LatLng(max(currentLocation.latitude, taskLocation.latitude), max(currentLocation.longitude, taskLocation.longitude)),
      );
      _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
      setState(() {});
    }
  }

  void buildingProcess({
    required LocationData locationData,
    required LatLng taskLocation,
    required double taskLat,
    required double taskLng,
    bool assignToCurrentPosition = false,
  }) async {
    final double currentLat = locationData.latitude.validate().toDouble();
    final double currentLng = locationData.longitude.validate().toDouble();
    final LatLng currentLocation = LatLng(currentLat, currentLng);

    if (assignToCurrentPosition) {
      currentPosition = locationData;
    }
    _fitBounds(currentLocation: currentLocation, taskLocation: taskLocation);

    final double distance = await calculateDistance(currentLat, currentLng, taskLat, taskLng);

    try {
      final String formattedDistance = distance < 1000 ? "${distance.round()} meters" : "${(distance / 1000).toStringAsFixed(2)} KM";

      isWithinRange = distance <= Config.allowedWorkRange;
      setState(() => isLoading = false);
    } catch (e) {
      log(e.toString());
      setState(() {
        isWithinRange = false;
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double taskLat = widget.ticketData.ticketLat.validate().toDouble();
    final double taskLng = widget.ticketData.ticketLng.validate().toDouble();
    final LatLng taskLocation = LatLng(taskLat, taskLng);

    return Scaffold(
      appBar: commonAppBarWidget("Verifying Your Location..."),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  aimLoader(context),
                  8.height,
                  Text(
                    'We’re checking your current location against the work site coordinates. This may take a moment.',
                    style: secondaryTextStyle(),
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 16),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: currentPosition != null ? LatLng(currentPosition!.latitude.validate(), currentPosition!.longitude.validate()) : const LatLng(0, 0),
                      zoom: 15,
                    ),
                    myLocationEnabled: true,
                    buildingsEnabled: true,
                    tiltGesturesEnabled: true,
                    onMapCreated: (controller) => _mapController = controller,
                    markers: Set.from([
                      Marker(
                        markerId: const MarkerId('taskLocation'),
                        position: taskLocation,
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        isWithinRange ? "Location Verified!" : 'Location Verification Failed!!',
                        style: boldTextStyle(color: isWithinRange ? Colors.green : Colors.red),
                      ),
                      16.height,
                      Text(
                        isWithinRange
                            ? "You are within the allowed range of the work site. You can now start work on this ticket."
                            : "You are not within ${getCalculatedDistance(Config.allowedWorkRange)} meters of the work site. Please move closer to the location and try again.",
                        textAlign: TextAlign.center,
                        style: secondaryTextStyle(color: isWithinRange ? Colors.green : Colors.red),
                      ),
                      16.height,
                      Observer(
                        builder: (_) {
                          return ButtonAppLoader(
                            isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.startWorkApiState].validate(),
                            child: AppButton(
                              text: isWithinRange ? "Start Task" : "Retry Verification",
                              disabledColor: context.primaryColor.withOpacity(0.4),
                              margin: isIOS ? const EdgeInsets.only(bottom: 24) : EdgeInsets.zero,
                              onTap: () async {
                                if (isWithinRange) {
                                  await showConfirmDialogCustom(
                                    context,
                                    title: "Confirm Start Work",
                                    subTitle: "You’re about to start work on this ticket. Ensure you’re ready to proceed before confirming",
                                    positiveText: "Start",
                                    primaryColor: context.primaryColor,
                                    onAccept: (_) async {
                                      final TicketWorks startWorkTempData = TicketWorks()
                                        ..ticketId = widget.ticketId.validate()
                                        ..startTime = DateFormat(ShowDateFormat.hhMmSs).format(
                                          DateTimeUtils.convertDateTimeToUTC(dateTime: DateTime.now()),
                                        )
                                        ..latitude = currentPosition?.latitude
                                        ..longitude = currentPosition?.longitude
                                        ..address = "done";

                                      await ticketStartWorkStore.ticketStartWork(data: startWorkTempData);
                                      widget.onLocationVerifiedSuccessfully();
                                      finish(context);
                                    },
                                  );
                                } else {
                                  setState(() => isLoading = true);
                                }
                              },
                              width: context.width(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
