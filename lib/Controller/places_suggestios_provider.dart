import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_places/Models/place_model.dart';
import 'package:my_places/Utilies/Remote_Data_Source/remote_data_source.dart';

class PlacesSuggestionsProvider extends StateNotifier<PlaceSuggestions> {
  PlacesSuggestionsProvider() : super(PlaceSuggestions(suggestions: []));

  RemoteDataSource remoteDataSource = RemoteDataSourceImpl();


  Future<void> getSuggestions({required String query}) async {
    final suggestions = await remoteDataSource.getSuggestions(query: query);
    state = suggestions;
  }
}

final placesSuggestionsProvider = StateNotifierProvider<PlacesSuggestionsProvider, PlaceSuggestions>(
    (ref) => PlacesSuggestionsProvider());