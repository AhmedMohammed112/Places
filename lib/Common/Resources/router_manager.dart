import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_places/Common/Resources/page_slide_transition.dart';
import 'package:my_places/Presentation/Screens/display_categories_screen.dart';
import 'package:my_places/Presentation/Screens/place_text_details_screen.dart';
import 'package:my_places/Presentation/Screens/view_place_location.dart';
import 'package:my_places/Presentation/Screens/select_on_map_screen.dart';

import '../../Models/place_model.dart';
import '../../Presentation/Screens/add_places_screen.dart';
import '../../Presentation/Screens/places_layout.dart';
import '../../Presentation/Screens/places_suggestions_screen.dart';
import '../../Presentation/Screens/selected_category_screen.dart';

class AppRoutes {
  static const String addPlace = '/add_place';
  static const String places = '/places';
  static const String placeDetail = '/place_detail';
  static const String map = '/map';
  static const String selectOnMap = '/select_on_map';
  static const String categoriesScreen = '/categories';
  static const String selectedCategoryScreen = '/selected_category';
  static const String placeSuggestions = '/place_suggestions';
}

class RouterManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.addPlace:
        final place = settings.arguments as Place?;
        return PageSlideTransition(page: AddPlaceScreen(place: place));
      case AppRoutes.places:
        return PageSlideTransition(page: const PlacesScreen());
      case AppRoutes.placeDetail:
        final place = settings.arguments as Place;
        return PageSlideTransition(page: PlaceTextDetails(place: place));
      case AppRoutes.map:
        final location = settings.arguments as PlaceLocation;
        return PageSlideTransition(page: MapScreen(location: location));
      case AppRoutes.selectOnMap:
        return MaterialPageRoute<LatLng>(
            builder: (context) => const SelectOnMapScreen());
      case AppRoutes.categoriesScreen:
        return PageSlideTransition(page: const CategoriesScreen());
      case AppRoutes.selectedCategoryScreen:
        final category = settings.arguments as String;
        return PageSlideTransition(page: FilteredPlaces(category: category));
        case AppRoutes.placeSuggestions:
          final query = settings.arguments as int;
        return PageSlideTransition(page: SuggestedPlacesScreen(index: query));
      default:
        return PageSlideTransition(page: const PlacesScreen());
    }
  }
}
