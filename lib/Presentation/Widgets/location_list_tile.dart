import 'package:flutter/Material.dart';
import 'package:my_places/Common/Resources/animated_phesical_model.dart';
import 'package:my_places/Common/Resources/color_manager.dart';
import 'package:my_places/Common/Resources/values_manager.dart';

import 'line.dart';
import 'my_text.dart';

class LocationListTile extends StatelessWidget {
  final String location;
  final String descreption;
  final VoidCallback onPress;

  const LocationListTile(
      {Key? key, required this.location, required this.onPress, required this.descreption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPhysicalModelExample(

      widget: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s20)
        ),
        leading: const Icon(Icons.location_pin,color: ColorManager.white,),
        title: MyText(text: location,style: Theme.of(context).textTheme.labelMedium),
        subtitle: MyText(text: descreption,style: Theme.of(context).textTheme.labelMedium),
        onTap: onPress,
      ), primaryColor: ColorManager.newPrimary.withOpacity(0.7), secondaryColor: ColorManager.newPrimary,
    );
  }
}
