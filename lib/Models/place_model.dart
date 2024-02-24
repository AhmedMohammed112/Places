import 'dart:convert';
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
  List<File>? image;
  String description;
  PlaceLocation location; 
  bool isFavourite;
  List<String>? types;

  Place({
    String? id,
    required this.name,
    this.image,
    required this.description,
    required this.location, 
    required this.isFavourite,
    this.types,
  }) : id = id ?? uuid.v4();

}

class PlaceSuggestions {
  final List<Suggestion> suggestions;

  PlaceSuggestions({required this.suggestions});

  factory PlaceSuggestions.fromJson(String json) {
    final List<Suggestion> suggestions = [];
    final Map<String, dynamic> data = jsonDecode(json);
    for (var item in data["features"]) {
      suggestions.add(Suggestion.fromJson(item));
    }
    return PlaceSuggestions(suggestions: suggestions);
  }
}

class Suggestion extends Place {
  String placeId;
  String openingHours;
  String phone;
  String website;

  Suggestion({
    required this.placeId,
    required this.openingHours,
    required this.phone,
    required this.website,
    required String name,
    required String description,
    required PlaceLocation location,
  }) : super(
          name: name,
          description: description,
          location: location,
          isFavourite: false,
        );

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    print("Json: ${json['properties']['name']}");
    return Suggestion(
        name: json["properties"]["name"] ?? "No Name",
        description: json["properties"]["operator"] ?? "No Description",
        location: PlaceLocation(
          latitude: json["geometry"]["coordinates"][1],
          longitude: json["geometry"]["coordinates"][0],
          address: json["properties"]["formatted"],
        ),
        placeId: json["properties"]["place_id"] ?? "No Place ID",
        openingHours: json["properties"]["opening_hours"] ?? "No Opening Hours",
        phone: json["properties"]["phone"] ?? "No Phone",
        website: json["properties"]["website"] ?? "No Website",
  );
  }
}


