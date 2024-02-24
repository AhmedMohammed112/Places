import'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_places/Common/Resources/values_manager.dart';
import '../../Common/Resources/router_manager.dart';
import '../../Common/shared_preferences.dart';
import '../../Controller/places_provider.dart';
import '../../Models/place_model.dart';
import '../../Utilies/Shared/constants.dart';
import '../../Utilies/Shared/shared_widgets.dart';
import '../Widgets/build_place_item.dart';
import '../Widgets/my_text.dart';
import '../Widgets/places_loading.dart';

class FilteredPlaces extends ConsumerStatefulWidget {
  final String category;
  const FilteredPlaces({required this.category,Key? key}) : super(key: key);

  @override
  ConsumerState<FilteredPlaces> createState() => _AllPlacesState();
}

class _AllPlacesState extends ConsumerState<FilteredPlaces> {
  late Future<void> _futurePlaces;

  @override
  void initState() {
    super.initState();
    _futurePlaces = ref.read(userPlaceProvider.notifier).getData();
  }

  @override
  Widget build(BuildContext context) {
    final databasePlaces = ref.watch(userPlaceProvider);
    final places = filterCategories(places: databasePlaces, type: widget.category);
    return Scaffold(
      appBar: AppBar( 
        title: MyText(text: widget.category,size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge),
        actions: [
          IconButton(
            onPressed: () {
              customShowDialog(
                  context: context,
                  title: "Remove Category",
                  content: MyText(text: "Are you sure you want to remove this category?",style: Theme.of(context).textTheme.labelMedium),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: MyText(text: "Cancel",style: Theme.of(context).textTheme.labelMedium)),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            placeTypes!.remove(widget.category);
                            SharedPref.setString(placeTypes!);
                            Navigator.pop(context);
                          });
                          Navigator.pop(context);
                        },
                        child: MyText(text: "Delete",style: Theme.of(context).textTheme.labelMedium)),
                  ]);
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.placeSuggestions,arguments: categories.indexOf(widget.category));
            },
            icon: const Icon(Icons.settings_suggest),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(AppSizes.s10),
        child: FutureBuilder(
        future: _futurePlaces,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return places.isEmpty
                ? Center(child: MyText(text: "There is no Places added yet",style: Theme.of(context).textTheme.labelMedium))
                : ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                return BuildNewPlaceItem(place: places[index]);
              },
            );
          } else {
            return const PlacesNewLoading();
          }
        },
    ),
      )
    );
  }
}

List<Place> filterCategories({required List<Place> places,required String type})
{
  List<Place> filteredPlaces = [];
  for (var place in places) {
    if(place.types!.contains(type))
    {
      filteredPlaces.add(place);
    }
  }
  return filteredPlaces;
}
