import 'dart:convert';
import 'package:my_places/Models/place_model.dart';
import '../Shared/constants.dart';
import '../Shared/network_helber.dart';

abstract class RemoteDataSource {
  Future<PlaceSuggestions> getSuggestions({required String query});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<PlaceSuggestions> getSuggestions({required String query}) async {
        final response = await NetworkUtilities.fetchUrl(
          Uri.parse(placeSuggestionsUrl(query)),
          headers: {
            'Content-Type': 'application/json',
          },
        );
        if(response != null) {
          return PlaceSuggestions.fromJson(response);
        }
        else {
          throw Exception('Failed to load suggestions');
        }
  }
}