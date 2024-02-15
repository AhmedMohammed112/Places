import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_places/Models/place_model.dart';
import 'package:my_places/Presentation/Widgets/my_text.dart';

import '../../Controller/places_provider.dart';
import '../../Controller/tabs_provider.dart';
import '../Widgets/build_place_item.dart';
import '../Widgets/places_loading.dart';

class FavouritePlaces extends ConsumerStatefulWidget {
  const FavouritePlaces({Key? key}) : super(key: key);

  @override
  ConsumerState<FavouritePlaces> createState() => _FavouritePlacesState();
}

class _FavouritePlacesState extends ConsumerState<FavouritePlaces> { 

    late Future<void> _futurePlaces;

  @override
  void initState() {
    super.initState();
    _futurePlaces = ref.read(userPlaceProvider.notifier).getData();
  } 

  @override
  Widget build(BuildContext context) {
    final retrievedPlaces = ref.watch(userPlaceProvider);

    final places = filterFavourites(places: retrievedPlaces);
    return FutureBuilder(
      future: _futurePlaces,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return places.isEmpty ? Center(child: MyText(text: "There is no Places added yet",style: Theme.of(context).textTheme.labelMedium))
              : ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {

              return InkWell(
                  onTap: () {
                    ref.read(tabsProvider.notifier).changeIndex(0);
                  },
                  child: BuildNewPlaceItem(place: places[index]));
            },
          );
        } else {
          return const PlacesNewLoading();
        }
      },
    );
  }
} 
List<Place> filterFavourites({required List<Place> places}) 
{
  List<Place> favouritePlaces = []; 
  for (var place in places) {
        if(place.isFavourite)
        {
          favouritePlaces.add(place);
        }    
  }
  return favouritePlaces;
}
