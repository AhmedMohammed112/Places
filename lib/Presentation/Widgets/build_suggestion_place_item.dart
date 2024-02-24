import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/Material.dart';

import '../../Common/Resources/animated_phesical_model.dart';
import '../../Common/Resources/color_manager.dart';
import '../../Common/Resources/router_manager.dart';
import '../../Common/Resources/values_manager.dart';
import '../../Models/place_model.dart';
import 'my_text.dart';

class BuildSuggestionsPlaceItem extends StatelessWidget {
  final Suggestion place;
  const BuildSuggestionsPlaceItem({Key? key, required this.place,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPhysicalModelExample(
      widget: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.s15,),
              MyText(
                text: place.name,
                color: ColorManager.black,
                size: 25,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorManager.black),
              ),
              const SizedBox(height: AppSizes.s10,),
              MyText(
                text: place.description,
                size: 12,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorManager.grey),
              ),
              const SizedBox(height: AppSizes.s10,),
              MyText(
                text: place.location.address,
                size: 12,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorManager.grey),
              ),
              const SizedBox(height: AppSizes.s10,),
              MyText(
                text: place.openingHours,
                size: 12,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorManager.grey),
              ),
               const SizedBox(height: AppSizes.s10,),
              // button to show place detail
              Row(
                children: [
                  Container(
                    width: AppSizes.s100,
                    height: AppSizes.s40,
                    decoration: BoxDecoration(
                      color: ColorManager.newPrimary,
                      borderRadius: BorderRadius.circular(AppSizes.s10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.map, arguments: place.location);
                      },
                      child: MyText(
                        text: "GO",
                        size: 14,
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorManager.white),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSizes.s10,),
                  Container(
                    width: AppSizes.s200,
                    height: AppSizes.s40,
                    decoration: BoxDecoration(
                      color: ColorManager.newPrimary,
                      borderRadius: BorderRadius.circular(AppSizes.s10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Place newPlace = Place(
                          name: place.name,
                          description: place.description,
                          location: place.location,
                          image: place.image,
                          isFavourite: false,
                        );
                        Navigator.pushNamed(context, AppRoutes.addPlace, arguments: newPlace);
                      },
                      child: MyText(
                        text: "Add to My Places",
                        size: 14,
                        color: ColorManager.white,
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorManager.white),
                      ),
                    ),
                  ),
                ],
              ),
        ]),
      ),
      primaryColor: ColorManager.lightPurple,
      secondaryColor: ColorManager.blueAccent.withAlpha(150),
    );

  }
}




