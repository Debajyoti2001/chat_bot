import 'package:flutter/material.dart';

class WhiteThemeColors {
   Color scaffoldBackgroundColor = const Color(0xfff3f6fd);
   Color cardColor = const Color(0xffE1ECF0);
   Color drawerColor = const Color(0xFFF6F8FE);
   Color appBarColor = const Color(0xff215cec);
   Color iconColor = Colors.black;
   Color textColor = Colors.black.withOpacity(0.8);
}
class DarkThemeColors{
   Color scaffoldBackgroundColor = const Color(0xff090A1E);
   Color cardColor = const Color(0xff191F3D);
   Color drawerColor = const Color(0xFFF6F8FE);
   Color appBarColor = const Color(0xff1E1F39);
   Color iconColor = Colors.white;
   Color textColor = Colors.white;
}


class Pallete {
   static const Color mainFontColor = Color.fromRGBO(19, 61, 95, 1);
   static const Color firstSuggestionBoxColor = Color.fromRGBO(165, 231, 244, 1);
   static const Color secondSuggestionBoxColor =
   Color.fromRGBO(157, 202, 235, 1);
   static const Color thirdSuggestionBoxColor = Color.fromRGBO(162, 238, 239, 1);
   static const Color assistantCircleColor = Color.fromRGBO(209, 243, 249, 1);
   static const Color borderColor = Color.fromRGBO(200, 200, 200, 1);
   static const Color blackColor = Colors.black;
   static const Color whiteColor = Colors.white;
}
// List<String> models = [
//   "MOdel-1",
//   "Model-2",
//   "Model-3",
//   "Model-4",
//   "Model-5",
//   "Model-6",
//   "Model-7",
// ];

// List<DropdownMenuItem<String>>? get getModelItem {
//   List<DropdownMenuItem<String>>? modelsItems =
//       List<DropdownMenuItem<String>>.generate(
//     models.length,
//     (index) => DropdownMenuItem(
//       value: models[index],
//       child: TextWidget(
//         label: models[index],
//         fontSize: 16,
//       ),
//     ),
//   );
//   return modelsItems;
// }

// final chatMessages = [
//   {
//     "msg": "Hello who are you?",
//     "chatIndex": 0,
//   },
//   {
//     "msg":
//         "Hello, I am ChatGPT, a large language model developed by OpenAI. I am here to assist you with any information or questions you may have. How can I help you today?",
//     "chatIndex": 1,
//   },
//   {
//     "msg": "What is flutter?",
//     "chatIndex": 0,
//   },
//   {
//     "msg":
//         "Flutter is an open-source mobile application development framework created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web. Flutter uses the Dart programming language and allows for the creation of high-performance, visually attractive, and responsive apps. It also has a growing and supportive community, and offers many customizable widgets for building beautiful and responsive user interfaces.",
//     "chatIndex": 1,
//   },
//   {
//     "msg": "Okay thanks",
//     "chatIndex": 0,
//   },
//   {
//     "msg":
//         "You're welcome! Let me know if you have any other questions or if there's anything else I can help you with.",
//     "chatIndex": 1,
//   },
// ];
