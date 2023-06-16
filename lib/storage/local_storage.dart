import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
  static Future<bool>setTheme(String theme)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString('theme', theme);
    return result;
  }

  static Future<String?>getTheme()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? theme = sharedPreferences.getString('theme');
    return theme;
  }

  static Future<bool>setScreen(String screen)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString('screen', screen);
    return result;
  }

  static Future<String?>getScreen()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? screen = await sharedPreferences.getString('screen');
    return screen;
  }
}