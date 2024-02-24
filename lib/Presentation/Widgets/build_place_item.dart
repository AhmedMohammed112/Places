import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/Material.dart';

import '../../Common/Resources/animated_phesical_model.dart';
import '../../Common/Resources/color_manager.dart';
import '../../Common/Resources/router_manager.dart';
import '../../Common/Resources/values_manager.dart';
import '../../Models/place_model.dart';
import 'my_text.dart';

class BuildNewPlaceItem extends StatelessWidget {
  final Place place;
  const BuildNewPlaceItem({Key? key, required this.place,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPhysicalModelExample(
      widget: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                      options: CarouselOptions(
                        height: AppSizes.s200,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        aspectRatio: 1,
                        initialPage: 0,
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
                            return ClipRRect(
                                borderRadius: BorderRadius.circular(AppSizes.s20),
                                child: Image.file(i,fit: BoxFit.fill, width: double.infinity));
                          },
                        );
                      }).toList(),
                    ),
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
              // button to show place detail
              Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: AppSizes.s30,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.placeDetail, arguments: place);
                    },
                    icon: const Center(
                      child: Icon(
                        Icons.navigate_next,
                        size: AppSizes.s30,
                      ),
                    ),
                  ),
                ),
              ),
        ]),
      ),
      primaryColor: ColorManager.lightPurple,
      secondaryColor: ColorManager.blueAccent.withAlpha(150),
    );

  }
}




