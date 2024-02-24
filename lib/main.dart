import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:my_places/Common/Resources/router_manager.dart';
import 'package:my_places/Common/Resources/theme_manager.dart';
import 'package:my_places/Common/Theme_Cubit/theme_cubit.dart';
import 'Common/shared_preferences.dart';
import 'Utilies/Shared/constants.dart';
import 'Utilies/Shared/location_helper.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();


  // Get Current User Location
  Location myLocation = await getCLocation();
  myLocationData = await myLocation.getLocation();

  if(await SharedPref.getFirstTime()){
    await SharedPref.setString(categories).then((value) => {
      placeTypes = categories
    });
    await SharedPref.setFirstTime();
  }
  else
  {
    placeTypes = await SharedPref.getString();
  }

  bool isDark = SharedPref.getData(key: 'IsDark') ?? false;


  runApp(ProviderScope(child: MyApp(isDark: isDark)));
}

class MyApp extends ConsumerStatefulWidget {
  final bool? isDark;
  const MyApp({Key? key, this.isDark}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ref.watch(themeProvider.notifier).isDark ? ThemeMode.dark : ThemeMode.light,
      theme: getThemeData(),
      darkTheme: getDarkThemeData(),
      onGenerateRoute: RouterManager.generateRoute,
      initialRoute: AppRoutes.places,
    );
  }
}

