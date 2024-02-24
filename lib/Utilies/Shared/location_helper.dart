import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';

// Function to get the image of the location
import '../../Models/place_model.dart';
import 'constants.dart';

String  locationImage(PlaceLocation? pickedLocation) {
  var lat = pickedLocation?.latitude;
  var lng = pickedLocation?.longitude;
  return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=12&size=400x400&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$apiKey';
}

// Function to get the formatted address of the location
Future<String> getFormattedAddress(double lat, double lng) async {
  final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';

  final response = await http.get(Uri.parse(url));
  final formattedAddress = json.decode(response.body)['results'][0]['formatted_address'];
  log(formattedAddress);
  return formattedAddress;
}


Future<Location> getCLocation() async
{
  Location location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {

    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {

    }
  }
  return location;
}

