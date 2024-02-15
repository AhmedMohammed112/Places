
import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:my_places/Models/autocomplete_predection_model.dart';

class PlaceAutocompleteResponse 

{
  final String? status; 
  final List<AutocompletePredection>? predictions;
  
  PlaceAutocompleteResponse({
    this.status, 
    this.predictions
  }); 

  factory PlaceAutocompleteResponse.fromJson(Map<String, dynamic> json) 
  {
    return PlaceAutocompleteResponse(
      status: json['status'] as String?, 
      predictions: json['predictions'] != null ? (json['predictions'] as List).map((i) => AutocompletePredection.fromJson(i)).toList() : null
    ); 
  } 

  static PlaceAutocompleteResponse? parseAutocompleteResponse(String responseBody) 
  {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlaceAutocompleteResponse.fromJson(parsed); 
  }
}