import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../constants/text_widget.dart';
import '../services/assets_manger.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.msg,
    required this.chatIndex,
  });

  final String msg;
  final int chatIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? Theme.of(context).cardColor : Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0 ? Assetsmanager.avatar : Assetsmanager.bot,
                  height: 40,
                  width: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: chatIndex == 0
                      ? TextWidget(
                          label: msg,
                          fontSize: 18,
                          color: Colors.white,
                        )
                      : AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              msg,
                              textStyle: const TextStyle(
                                color: Color(0xff666666),
                                fontSize: 18,
                              ),
                              speed: const Duration(milliseconds: 50),
                            ),
                          ],
                          isRepeatingAnimation: false,
                          repeatForever: false,
                          displayFullTextOnTap: true,
                          totalRepeatCount: 1,
                        ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
