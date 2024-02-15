import 'package:flutter/Material.dart';
import 'package:my_places/Common/Resources/color_manager.dart';
import 'package:my_places/Common/Resources/router_manager.dart';
import 'package:my_places/Common/Resources/values_manager.dart';
import 'package:my_places/Presentation/Screens/add_places_screen.dart';
import 'package:my_places/Presentation/Widgets/back_arrow.dart';
import 'package:my_places/Presentation/Widgets/my_text.dart';
import 'package:my_places/Presentation/Widgets/my_text_field.dart';
import '../../Common/shared_preferences.dart';
import '../../Utilies/Shared/constants.dart';
import '../../Utilies/Shared/shared_widgets.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var addedCategory = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackArrow(),
        title: MyText(text: "Categories",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge),
        actions: [
          IconButton(
            onPressed: () {
              customShowDialog(
                  context: context,
                  title: "Add Category",
                  content: MyTextFormField(
                    controller: addedCategory, hintText: "Category Name",
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: MyText(text: "Cancel",style: Theme.of(context).textTheme.labelMedium)),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            placeTypes!.add(addedCategory.text);
                            SharedPref.setString(placeTypes!);
                            Navigator.pop(context);
                          });
                          Navigator.pop(context);
                        },
                        child: MyText(text: "Add",style: Theme.of(context).textTheme.displayLarge)),
                  ]);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(placeTypes!.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.selectedCategoryScreen,arguments: placeTypes![index]);
              },
              child: Container(

                  decoration: BoxDecoration(
                    color: ColorManager.newPrimary.withAlpha(AppSizes.s120.toInt()),
                    borderRadius: BorderRadius.circular(AppSizes.s20),
                    border: Border.all(color: ColorManager.newPrimary,width: AppSizes.s2)
                  ),
                  height: AppSizes.s200,
                  child: Center(child: MyText(text: placeTypes![index],size: AppSizes.s15,style: Theme.of(context).textTheme.labelMedium)),

            )
          )
          );
        }),
      ),
    );
  }
}
