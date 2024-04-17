import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared_preferences.dart';

class ThemeProvider extends StateNotifier<bool> {
  ThemeProvider(bool isDark) : super(isDark);

  void changeTheme() {
    state = !state;
    print("Theme Changed to: $state");
    SharedPref.saveData(key: 'IsDark', value: state);
  }
}

final themeProvider = StateNotifierProvider<ThemeProvider, bool>((ref) {
  bool isDark = SharedPref.getData(key: 'IsDark') ?? false;
  return ThemeProvider(isDark);
});
