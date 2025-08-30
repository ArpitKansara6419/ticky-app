import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/config.dart';
import 'package:ticky/utils/enums.dart';

class LocationService {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/geocode/json';

  /// Method to get the country and city from a pin code/zip code
  static Future<Map<String, dynamic>> getCountryAndCity(String pinCode) async {
    appStore.setPinCodeLoaderStatus(true);
    final Uri url = Uri.parse('$_baseUrl?address=$pinCode&key=${Config.googleMapKey}');
    try {
      log("url ${url}");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        mainLog(message: response.body, label: 'response.body => ');
        final data = jsonDecode(response.body);
        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          final components = data['results'][0]['address_components'];
          final postcodeLocalities = data['results'][0]['postcode_localities'];

          String? city;
          String? country;
          String? countryCode;

          for (var component in components) {
            final types = component['types'] as List;
            if (types.contains('locality')) {
              city = component['long_name'];
            } else if (types.contains('country')) {
              country = component['long_name'];
              countryCode = component['short_name'];
            }
          }

          if (city != null && country != null) {
            log("${{'city': city, 'country': country, 'countryCode': countryCode, 'postal_codes': postcodeLocalities}}");
            appStore.setPinCodeLoaderStatus(false);
            return {'city': city, 'country': country, 'countryCode': countryCode, 'postal_codes': postcodeLocalities};
          } else {
            appStore.setPinCodeLoaderStatus(false);
            throw Exception('City or country not found for the given pin code.');
          }
        } else {
          appStore.setPinCodeLoaderStatus(false);
          throw Exception('No results found for the given pin code.');
        }
      } else {
        appStore.setPinCodeLoaderStatus(false);
        throw Exception('Failed to fetch location data: ${response.reasonPhrase}');
      }
    } catch (e) {
      appStore.setPinCodeLoaderStatus(false);
      throw Exception('Error occurred: $e');
    }
  } 
}
