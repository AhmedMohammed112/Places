import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Controller/places_provider.dart';
import '../Widgets/build_place_item.dart';
import '../Widgets/my_text.dart';
import '../Widgets/places_loading.dart';

class AllPlaces extends ConsumerStatefulWidget {
  const AllPlaces({Key? key}) : super(key: key);

  @override
  ConsumerState<AllPlaces> createState() => _AllPlacesState();
}

class _AllPlacesState extends ConsumerState<AllPlaces> {
  late Future<void> _futurePlaces;

  @override
  void initState() {
    super.initState();
    _futurePlaces = ref.read(userPlaceProvider.notifier).getData();
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(userPlaceProvider);
    return FutureBuilder(
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
    );
  }
}
