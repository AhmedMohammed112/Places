import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? sharedPreferences;

  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // create function to check if it is the first time to open the app or not
  static Future setFirstTime() async {
    sharedPreferences!.setBool('first_time', false);
  }
  //explain the function

static Future<bool> getFirstTime() async {
    return sharedPreferences!.getBool('first_time') ?? true;
  }


  static Future setString(List<String> value) async {
    sharedPreferences!.setStringList('categories', value);
  }

static Future<List<String>> getString() async {
    return sharedPreferences!.getStringList('categories') ?? [];
  }

static Future<bool> saveData({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }

static bool? getData({
    required String key,
  }) {
    return sharedPreferences!.getBool(key);
  }

}