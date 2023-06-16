
import 'package:flutter/material.dart';

import '../storage/local_storage.dart';

class ThemeProvider with ChangeNotifier{
  late ThemeMode themeMode;
  late bool isChecked;
  ThemeProvider(String theme){
    if(theme == 'light'){
      themeMode = ThemeMode.light;
      isChecked = false;
    }
    else{
      themeMode = ThemeMode.dark;
      isChecked = true;
    }
    notifyListeners();
  }
  void changeTheme()async{
    if(themeMode == ThemeMode.light){
      themeMode = ThemeMode.dark;
      isChecked = true;
      await LocalStorage.setTheme('dark');
    }
    else{
      themeMode = ThemeMode.light;
      isChecked = false;
     await LocalStorage.setTheme('light');
    }
    notifyListeners();
  }
}