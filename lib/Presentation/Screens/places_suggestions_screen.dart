import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_places/Controller/places_suggestios_provider.dart';
import 'package:my_places/Presentation/Widgets/build_suggestion_place_item.dart';
import '../../Common/Resources/values_manager.dart';
import '../../Utilies/Shared/constants.dart';
import '../Widgets/my_text.dart';
import '../Widgets/suggested_places_loading.dart';

class SuggestedPlacesScreen extends ConsumerStatefulWidget {
  final int index;
  const SuggestedPlacesScreen({required this.index,Key? key}) : super(key: key);

  @override
  ConsumerState<SuggestedPlacesScreen> createState() => _SuggestedPlacesState();
}

class _SuggestedPlacesState extends ConsumerState<SuggestedPlacesScreen> {
  late Future<void> _futurePlaces;

  @override
  void initState() {
    super.initState();
    _futurePlaces = ref.read(placesSuggestionsProvider.notifier).getSuggestions(query: suggestions[widget.index]);
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesSuggestionsProvider);
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: categories[widget.index],size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge),
      ),
      body: FutureBuilder(
        future: _futurePlaces,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return places.suggestions.isEmpty
                ? Center(child: MyText(text: "There is no Places added yet",style: Theme.of(context).textTheme.labelMedium))
                : ListView.builder(
              itemCount: places.suggestions.length,
              itemBuilder: (context, index) {
                return BuildSuggestionsPlaceItem(place: places.suggestions[index]);
              },
            );
          } else {
            return const SuggestedPlacesLoading();
          }
        },
      ),
    );
  }
}
