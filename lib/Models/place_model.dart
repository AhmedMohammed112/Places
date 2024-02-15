import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation(
      {required this.latitude, required this.longitude, required this.address});

  factory PlaceLocation.fromJson(Map<String, dynamic> json) => PlaceLocation(
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
      );
}

class Place {
  String? id;
  String name;
  List<File> image;
  String description;
  PlaceLocation location; 
  bool isFavourite;
  List<String> types;

  Place({
    String? id,
    required this.name,
    required this.image,
    required this.description,
    required this.location, 
    required this.isFavourite,
    required this.types,
  }) : id = id ?? uuid.v4();
}


