import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared_preferences.dart';

class ThemeProvider extends StateNotifier<bool> {
  ThemeProvider() : super(false);

  bool isDark = false;

  void changeTheme({bool? fromShared}) {
    if (fromShared != null) {
      // change the theme and save it to shared preferences and state
      isDark = fromShared;
      SharedPref.saveData(key: 'IsDark', value: isDark);
      state = isDark;
    } else {
      // change the theme and save it to shared preferences and state
      isDark = !isDark;
      SharedPref.saveData(key: 'IsDark', value: isDark);
      state = isDark;
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeProvider, bool>((ref) {
  return ThemeProvider();
});
