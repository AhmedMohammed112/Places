import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_places/Common/Resources/router_manager.dart';
import 'package:my_places/Presentation/Widgets/my_elevation_button.dart';
import '../../Common/Resources/color_manager.dart';
import '../../Common/Resources/values_manager.dart';
import '../../Controller/places_provider.dart';
import '../../Models/place_model.dart';
import '../../Utilies/Shared/location_helper.dart';
import '../../Utilies/Shared/shared_widgets.dart';
import '../Widgets/back_arrow.dart';
import '../Widgets/my_text.dart';

class PlaceTextDetails extends ConsumerWidget {
  final Place place;

  const PlaceTextDetails({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackArrow(),
        title: MyText(
          text: place.name, style: Theme.of(context).textTheme.displayLarge
        ),
        actions: [
          IconButton(
              onPressed: () {
                // make alert dialog to confirm delete
                customShowDialog(
                    context: context,
                    title: "Delete Confirmation",
                    content: MyText(
                      text: "Are you sure you want to delete this place?",
                        style: Theme.of(context).textTheme.labelMedium
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: MyText(text: "Cancel",style: Theme.of(context).textTheme.labelMedium)),
                      TextButton(
                          onPressed: () {
                            ref
                                .read(userPlaceProvider.notifier)
                                .deletePlace(place: place);
                            Navigator.pop(context);
                          },
                          child: MyText(text: "Delete",style: Theme.of(context).textTheme.labelMedium)),
                    ]);
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                ref
                    .read(userPlaceProvider.notifier)
                    .addToFavourites(place: place);
              },
              icon: Icon(
                Icons.favorite,
                color: place.isFavourite == true
                    ? ColorManager.error
                    : ColorManager.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height - 80,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  aspectRatio: 1,
                  initialPage: 0,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: place.image!.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                        ),
                        child: Image.file(
                          i,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              // simple button to display the buttom sheet
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheetDetails(
                      context: context,
                      builder: (context) =>
                          placeDetails(context: context, place: place),
                    );
                  },
                  icon: const Icon(Icons.info_outline_rounded),
                  color: ColorManager.white,
                  iconSize: AppSizes.s30,
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

Future<Widget> showModalBottomSheetDetails({required BuildContext context, required WidgetBuilder builder}) async {
  return await showModalBottomSheet(
    isDismissible: true,
    context: context,
    builder: builder,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppSizes.s50),
        topRight: Radius.circular(AppSizes.s50),
      ),
    ),
    isScrollControlled: true,
  );
}

Widget placeDetails({required BuildContext context, required Place place}) {
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.s20,
      ),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyText(
            text: place.name,
            size: AppSizes.s30,
              style: Theme.of(context).textTheme.displayLarge
          ),
          const SizedBox(
            height: AppSizes.s20,
          ),
          MyText(
            text: place.description,
            size: AppSizes.s15,
              style: Theme.of(context).textTheme.displayLarge
          ),
          const SizedBox(
            height: AppSizes.s10,
          ),
          MyText(
            text: place.location.address,
            size: AppSizes.s15,
            bold: true,
              style: Theme.of(context).textTheme.displayLarge
          ),
          const SizedBox(
            height: AppSizes.s10,
          ),
          MyText(
            text: "Types: ",
            size: AppSizes.s15,
              style: Theme.of(context).textTheme.displayLarge
          ),
          const SizedBox(
            height: AppSizes.s10,
          ),
          Wrap(
            children: place.types
                !.map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyElevationButton(
                      padding:  15,
                      radius: 20,
                            buttonColor: ColorManager.newPrimary,
                      widthButton: AppSizes.s120,
                      heightButton: AppSizes.s50,
                      size: AppSizes.s15,
                      textButton: e,
                      fun: () {
                        Navigator.pushNamed(context, AppRoutes.selectedCategoryScreen,arguments: e);
                      },
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(
            height: AppSizes.s20,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.map,
                    arguments: place.location);
              },
              child: Container(
                padding: const EdgeInsets.all(AppSizes.s10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(locationImage(place.location)),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.s10),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: AppSizes.s20,
          ),
          MyElevationButton(
            textButton: "GO",
            fun: () {
              Navigator.pushNamed(context, AppRoutes.map,
                  arguments: place.location);
            },
          ),
        ],
      ),
    ),
  );
}
