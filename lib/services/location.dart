import 'package:geolocator/geolocator.dart';
import 'package:user_interface/constants.dart';
import 'package:user_interface/services/api_constants.dart';
import 'package:user_interface/services/network_helper.dart';

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude,this.longitude});

  static Future<Location> getCurrentLocation() async {
    try {
      Position position = await Geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low,forceAndroidLocationManager: true);

      return Location(
        latitude: position.latitude,
        longitude: position.longitude
      );
    } catch (e) {
      print(e);
      return Location();
    }
  }

  // Reverse Geocoding
  Future<String> getNameFromLocation() async{
    if(latitude==null || longitude==null) {
      return 'Turn on location';
    }
    ApiData locationIQ = ApiConstants.locationIQ;
    String url = '${locationIQ.baseUrl}reverse.php?key=${locationIQ.apiKey}&lat=$latitude&lon=$longitude&format=json';
    var networkResponse = await NetworkHelper(url).getData();
    if(networkResponse == null) {
      return '';
    }

    return networkResponse['display_name'];
  }

  // Forward Geocoding
  static Future<Location> getLocationFromName(String name) async{
    ApiData locationIQ = ApiConstants.locationIQ;
    String url = '${locationIQ.baseUrl}search.php?key=${locationIQ.apiKey}&q=$name&format=json';
    var networkResponse = await NetworkHelper(url).getData();
    if(networkResponse == null) {
      return Location();
    }

    return Location(
      latitude: double.parse(networkResponse[0]['lat']),
      longitude: double.parse(networkResponse[0]['lon']),
    );
  }
}