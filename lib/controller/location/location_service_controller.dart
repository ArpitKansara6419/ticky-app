import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ticky/model/location/location_model.dart';
import 'package:ticky/utils/date_utils.dart';

class LocationServiceController {
  // Method to determine if location services are enabled and permissions are granted
  static Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      throw Exception('Location services are disabled.');
    }

    // Check if permissions are granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, throw exception
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      throw Exception('Location permissions are permanently denied.');
    }

    // If permissions are granted, return the current position
    return await Geolocator.getCurrentPosition();
  }

  // Method to get current location (latitude and longitude)
  static Future<Map<String, dynamic>> getCurrentLocation() async {
    try {
      Position position = await _determinePosition();

      // Get timestamp of the location data
      DateTime timestamp = DateTimeUtils.convertDateTimeToUTC(
        dateTime: DateTime.now(),
      );

      // Reverse geocode to get the address from latitude and longitude
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      // Extract address details from the first Placemark
      Placemark place = placemarks[0];

      String address = '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';

      // Return the location details in a map
      return {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'address': address,
        'timestamp': timestamp.toString(),
      };
    } catch (e) {
      // Handle exceptions here
      print('Error occurred while fetching location: $e');
      rethrow;
    }
  }
}

Future<LocationModel> getLocationDetails() async {
  return LocationModel.fromJson(await LocationServiceController.getCurrentLocation());
}
