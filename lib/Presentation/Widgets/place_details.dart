import 'package:flutter/Material.dart';
import 'package:my_places/Models/place_model.dart';

import '../../Common/Resources/color_manager.dart';
import '../../Common/Resources/router_manager.dart';
import '../../Common/Resources/values_manager.dart';
import '../../Utilies/Shared/location_helper.dart';
import 'my_elevation_button.dart';
import 'my_text.dart';

class PlaceDetails extends StatelessWidget {
  final Place place;
  const PlaceDetails({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.all(AppPadding.p8,),
                  child: MyElevationButton(
                    padding: AppPadding.p15,
                    radius: AppSizes.s20,
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
}
