// import 'package:flutter/material.dart';
//
// import '../constants/color.dart';
// import '../constants/text_widget.dart';
// import '../widgets/drop_down.dart';
//
// class Services {
//   static Future<void> showModelSheet({required BuildContext context}) async {
//     await showModalBottomSheet(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       backgroundColor: WhiteThemeColors().scaffoldBackgroundColor,
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.all(18.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Flexible(
//                 child: TextWidget(
//                   label: 'Choose Model',
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                 ),
//               ),
//               Flexible(
//                 flex: 2,
//                 child: DropDownWidget(),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
