import 'package:flutter/material.dart';
import 'package:my_places/Common/Resources/color_manager.dart';
import 'package:my_places/Presentation/Widgets/my_text.dart';

import '../../Common/Resources/values_manager.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(AppSizes.s40),
          topRight: Radius.circular(AppSizes.s40),
        )
    ),
      elevation: 0,
      surfaceTintColor: Colors.red,
      clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children:  [
            Container(
              height: AppSizes.s250,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(AppSizes.s60),
                    topRight: Radius.circular(AppSizes.s60),
                  )
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: AppSizes.s60,
                      backgroundColor: ColorManager.newPrimary,
                    ),
                    SizedBox(height: AppSizes.s10,),
                    MyText(text: 'User Name',size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge,)
                  ],
                )
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home,size: AppSizes.s30,),
              trailing: const Icon(Icons.arrow_forward_ios),
              title: MyText(text: 'Home',size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge,),
            ),
            ListTile(
              leading: const Icon(Icons.favorite,size: AppSizes.s30,),
              trailing: const Icon(Icons.arrow_forward_ios),
              title: MyText(text: 'Favourite',size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge,),
            ),
            ListTile(
              leading: const Icon(Icons.question_mark_outlined,size: AppSizes.s30,),
              trailing: const Icon(Icons.arrow_forward_ios),
              title: MyText(text: 'New Place',size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge,),
            ),
            ListTile(
              leading: const Icon(Icons.settings,size: AppSizes.s30,),
              trailing: const Icon(Icons.arrow_forward_ios),
              title: MyText(text: 'Settings',size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge,),
            ),
          ],
        ),
    );
  }
}
