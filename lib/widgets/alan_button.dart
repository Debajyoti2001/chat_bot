import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';

class AlanButtton extends StatefulWidget {
  const AlanButtton({Key? key}) : super(key: key);

  @override
  State<AlanButtton> createState() => _AlanButttonState();
}

class _AlanButttonState extends State<AlanButtton> {
  _AlanButttonState() {
    /// Init Alan Button with project key from Alan AI Studio
    AlanVoice.addButton(
        "36822f57b997c147299b7ed0402dbd472e956eca572e1d8b807a3e2338fdd0dc/stage",
        );

    /// Handle commands from Alan AI Studio
    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
