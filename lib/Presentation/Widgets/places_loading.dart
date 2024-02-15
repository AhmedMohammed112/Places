import 'package:flutter/Material.dart';
import '../../Common/Resources/animated_phesical_model.dart';
import '../../Common/Resources/color_manager.dart';
import '../../Common/Resources/values_manager.dart';

class PlacesLoading extends StatelessWidget {
  const PlacesLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder( 
      itemCount: 5,
        itemBuilder: (context,index) {
          return AnimatedPhysicalModelExample(
            widget: Padding(
              padding: const EdgeInsets.only(top: AppPadding.p15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   ListTile(
                      leading: const CircleAvatar(
                        radius: AppSizes.s30,
                        backgroundColor: ColorManager.grey,
                      ),
                      title: const Skeleton(height: 20,),
                      trailing: Icon(
                          Icons.navigate_next,
                          size: 30,
                          color: ColorManager.black.withOpacity(0.5),
                        ),
                      
                      subtitle: const Skeleton(height: 10, width: 10,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p20),
                    child: Container(height: 20,decoration: BoxDecoration(color: ColorManager.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10)),)
                  ),
                ],
              ),
            ),
            primaryColor: ColorManager.white,
            secondaryColor: ColorManager.newPrimary,
          );
        }
    );
  }
}


class Skeleton extends StatelessWidget {
  final double height;
  final double width;
  const Skeleton({Key? key, required this.height, this.width = double.infinity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: height, width: width ,decoration: BoxDecoration(color: ColorManager.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10)),);
  }
}


class PlacesNewLoading extends StatelessWidget {
  const PlacesNewLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context,index) {
          return AnimatedPhysicalModelExample(
            widget: const Padding(
              padding: EdgeInsets.all(AppPadding.p16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(height: AppSizes.s200),
                    SizedBox(height: AppSizes.s15,),
                    Skeleton(height: AppSizes.s20, width: AppSizes.s200,),
                    SizedBox(height: AppSizes.s10,),
                    Skeleton(height: AppSizes.s20),
                    SizedBox(height: AppSizes.s10,),
                    // button to show place detail
                    Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                          radius: AppSizes.s30,
                          backgroundColor: ColorManager.grey,

                      ),
                    ),
                  ]),
            ), primaryColor: ColorManager.lightPurple, secondaryColor: ColorManager.lightPurple,
          );
        }
    );
  }
}
