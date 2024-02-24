import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_places/Common/Resources/color_manager.dart';
import 'package:my_places/Presentation/Screens/place_text_details_screen.dart';
import 'package:my_places/Presentation/Screens/view_place_location.dart';
import 'package:my_places/Presentation/Widgets/my_text.dart';
import '../../Controller/places_provider.dart';
import '../../Controller/tabs_provider.dart';
import '../../Models/place_model.dart';
import '../../Utilies/Shared/shared_widgets.dart';
import '../Widgets/back_arrow.dart';

class PlaceDetailsScreen extends ConsumerStatefulWidget {
  final Place place;
  const PlaceDetailsScreen({required this.place,Key? key}) : super(key: key);

  @override
  ConsumerState<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends ConsumerState<PlaceDetailsScreen> {

  var tabs;

  @override
  void initState() {
    tabs = [
      PlaceTextDetails(place: widget.place),
      MapScreen(location: widget.place.location),
    ];

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final tabsNotifier = ref.watch(tabsProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          leading: const BackArrow(),
          title: MyText(text: widget.place.name, ),
          actions: [
            IconButton(onPressed: (){
              // make alert dialog to confirm delete
              customShowDialog(context: context, title: "Delete Confirmation", content: MyText(text: "Are you sure you want to delete this place?",), actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: MyText(text: "Cancel")),
                TextButton(onPressed: (){
                  ref.read(userPlaceProvider.notifier).deletePlace(place: widget.place);
                  Navigator.pop(context);
                }, child: MyText(text: "Delete")),
              ]
              );
            }, icon: const Icon(Icons.delete)),
            IconButton(onPressed: () {
              ref.read(userPlaceProvider.notifier).addToFavourites(place: widget.place);
            }, icon: Icon(Icons.favorite,color: widget.place.isFavourite == true ? ColorManager.error : ColorManager.white,))
          ],
        ),

        body: Container(
            decoration: sharedGradient(),
            child: Column(
              children: [
                DefaultTabController(
                    animationDuration: const Duration(seconds: 1),
                    length: tabs.length,
                    child: TabBar(
                        onTap: (value) {
                          tabsNotifier.changeIndex(value);
                        },
                        tabs: [
                          Tab(child: MyText(text: "Details"),),
                          Tab(child: MyText(text: "Map"),),
                        ]
                    )
                ),
                Expanded(child: tabs[ref.watch(tabsProvider)]),
              ],
            )
        ),
    );
  }
}

//comand to get sha key from signingReport
//./gradlew signingReport