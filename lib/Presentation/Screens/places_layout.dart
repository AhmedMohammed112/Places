import 'package:flutter/Material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_places/Common/Resources/values_manager.dart';
import 'package:my_places/Common/Theme_Cubit/theme_cubit.dart';
import 'package:my_places/Presentation/Screens/all_places_screen.dart';
import 'package:my_places/Presentation/Screens/favourite_places_screen.dart';
import 'package:my_places/Presentation/Widgets/my_text.dart';
import '../../Common/Resources/router_manager.dart';
import '../../Controller/tabs_provider.dart';
import 'drawer_screen.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> { 

  var tabs = [
    const AllPlaces(),
    const FavouritePlaces(),
  ];


  @override
  Widget build(BuildContext context) {
    final tabsNotifier = ref.watch(tabsProvider.notifier);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: MyText(
          text: 'My Places',
          size: AppSizes.s20,
            style: Theme.of(context).textTheme.displayLarge
        ),
        actions: [
          IconButton(onPressed: () {
                // change the theme
            //ref.read(themeProvider.notifier).changeTheme();
            Navigator.pushNamed(context, AppRoutes.categoriesScreen);
          }, icon: const Icon(Icons.filter_alt)),
          // Theme Switcher
          IconButton(
            onPressed: () {
              // change the theme
              ref.read(themeProvider.notifier).changeTheme();
            },
            icon: const Icon(Icons.brightness_4),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DefaultTabController(
              animationDuration: const Duration(seconds: 2),
            length: tabs.length,
            child: TabBar(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              padding: const EdgeInsets.all(AppPadding.p8),
              // make user navigate between tabs by swiping
               //dragStartBehavior: DragStartBehavior.start,
              physics: const BouncingScrollPhysics(),
              // design the tabs
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor,
                ),
                // remove the horizontal line under the tabs
                dividerHeight: 0,
                onTap: (value) {
                  tabsNotifier.changeIndex(value);
                },
                tabs: [
                  Tab(child: MyText(text: "All Places",style: Theme.of(context).textTheme.displayLarge),),
                  Tab(child: MyText(text: "Favourite Places",style: Theme.of(context).textTheme.displayLarge),),
                ]
            )
        ),
            Expanded(child: tabs[ref.watch(tabsProvider)]),
            // make a space between the tabs and the add new place button
          ],
        ),
      ),

      // Add New Place Button
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addPlace);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

