import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

Future<double> calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) async {
  log("startLatitude => $startLatitude");
  log("startLongitude => $startLongitude");
  log("endLatitude => $endLatitude");
  log("endLongitude => $endLongitude");
  const double earthRadius = 6371.0; // Radius of the Earth in kilometers
  const double degreeToRadian = pi / 180;

  final double lat1 = startLatitude * degreeToRadian;
  final double lon1 = startLongitude * degreeToRadian;
  final double lat2 = endLatitude * degreeToRadian;
  final double lon2 = endLongitude * degreeToRadian;

  final double dLat = lat2 - lat1;
  final double dLon = lon2 - lon1;

  final double a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  final double distance = earthRadius * c * 1000; // Convert to meters

  return distance.toStringAsFixed(2).toDouble();
}

double calculateDistanceWithoutFuture(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
  const double earthRadius = 6371.0; // Radius of the Earth in kilometers
  const double degreeToRadian = pi / 180;

  final double lat1 = startLatitude * degreeToRadian;
  final double lon1 = startLongitude * degreeToRadian;
  final double lat2 = endLatitude * degreeToRadian;
  final double lon2 = endLongitude * degreeToRadian;

  final double dLat = lat2 - lat1;
  final double dLon = lon2 - lon1;

  final double a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  final double distance = earthRadius * c * 1000; // Convert to meters

  return distance.toStringAsFixed(2).toDouble();
}

Future<Map<String, dynamic>> getDistanceFromLatLong({required LatLng address}) async {
  try {
    // Step 1: Geocode the provided address to get latitude and longitude

    final double addressLat = address.latitude;
    final double addressLng = address.longitude;

    // Step 2: Get the user's current location
    Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Step 4: Calculate the distance between the user's location and the address location
    final double distance = await calculateDistance(
      currentPosition.latitude,
      currentPosition.longitude,
      addressLat,
      addressLng,
    );
    // Step 5: Format distance to return in meters or kilometers
    String formattedDistance;
    if (distance < 1000) {
      formattedDistance = "${distance.round()} meters";
    } else {
      formattedDistance = "${(distance / 1000).toStringAsFixed(2)} KM";
    }

    // Step 6: Return the distance information
    return {
      "distance_meter": distance,
      "formatted_distance": formattedDistance,
      "user_latitude": currentPosition.latitude,
      "user_longitude": currentPosition.longitude,
      "address_latitude": addressLat,
      "address_longitude": addressLng,
      "message": "The distance to the specified address is $formattedDistance."
    };
  } catch (e) {
    return {
      "message": "Error: $e",
    };
  }
}
