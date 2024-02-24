import 'package:flutter/Material.dart';

import '../../Common/Resources/color_manager.dart';
import '../../Common/Resources/values_manager.dart';
import '../../Presentation/Widgets/my_text.dart';
BoxDecoration sharedGradient() {
  return const BoxDecoration(
      gradient: LinearGradient(
          colors: [
            ColorManager.deepPurpleAccent,
            ColorManager.newPrimary,
            ColorManager.blueAccent,
            ColorManager.pinkAccent,
            ColorManager.purpleAccent,
            ColorManager.redAccent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          // make curves design
          stops: [0.1, 0.3, 0.5, 0.7, 0.9, 1],
          transform: GradientRotation(0.5)));
}

Future<Widget> customShowDialog({required BuildContext context,required String title, required dynamic content,required List<Widget> actions}) async
{
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: AppSizes.s20,
          title: MyText(text: title,size: AppSizes.s20,style: Theme.of(context).textTheme.labelMedium),
          content: content,
          actions: actions,
        );
      }
  );
}
