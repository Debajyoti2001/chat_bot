
import 'package:chatbot/providers/chat_provider.dart';
import 'package:chatbot/providers/models_provider.dart';
import 'package:chatbot/providers/theme_provider.dart';
import 'package:chatbot/screens/chat_screen.dart';
import 'package:chatbot/screens/splash_screen.dart';
import 'package:chatbot/storage/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import 'constants/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String theme = await LocalStorage.getTheme() ?? 'light';
  String screen;
  if(await LocalStorage.getScreen() == null){
    screen = 'splash';
    LocalStorage.setScreen('chatScreen');
  }
  else{
    screen = 'chat';
  }
  runApp(MyApp(
    theme: theme, screen: screen,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;
  final String screen;
  const MyApp({super.key, required this.theme, required this.screen});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ModelsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ChatProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(theme),
          ),
        ],
        child: Builder(builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home: screen == 'splash' ? SplashScreen() : ChatScreen(),
            themeMode: themeProvider.themeMode,
            theme: CustomTheme.lightTheme,
            darkTheme: CustomTheme.darkTheme,
          );
        }));
  }
}
