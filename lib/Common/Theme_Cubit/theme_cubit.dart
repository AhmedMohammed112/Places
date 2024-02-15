import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared_preferences.dart';

class ThemeProvider extends StateNotifier<bool> {
  ThemeProvider() : super(false);

  bool isDark = false;

  void changeTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      state = isDark;
    } else {
      print('isDark: $fromShared');
      isDark = !isDark;
      print('isDark: $isDark');
      SharedPref.saveData(key: 'IsDark', value: isDark);
      state = isDark;
      print('state: $state');
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeProvider, bool>((ref) {
  return ThemeProvider();
});
