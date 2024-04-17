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

  // Initialize the Riverpod providers
  final isDark = SharedPref.getData(key: 'IsDark') ?? false;
  final themeProvider = StateNotifierProvider<ThemeProvider, bool>((ref) {
    return ThemeProvider(isDark);
  });

  if (await SharedPref.getFirstTime()) {
    await SharedPref.setString(categories).then((value) {
      placeTypes = categories;
    });
    await SharedPref.setFirstTime();
  } else {
    placeTypes = await SharedPref.getString();
  }

  runApp(ProviderScope(
    child: MyApp(isDark: isDark),
  ));
}

class MyApp extends ConsumerWidget {
  final bool isDark;

  const MyApp({Key? key, required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use ref.watch to watch the themeProvider and rebuild when its state changes
    final bool currentTheme = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // Use the currentTheme variable to determine the themeMode
      themeMode: currentTheme ? ThemeMode.dark : ThemeMode.light,
      theme: getThemeData(),
      darkTheme: getDarkThemeData(),
      onGenerateRoute: RouterManager.generateRoute,
      initialRoute: AppRoutes.places,
    );
  }
}
