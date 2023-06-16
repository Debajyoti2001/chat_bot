import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../constants/text_widget.dart';
import 'assistant_page.dart';
import '../providers/chat_provider.dart';
import '../providers/models_provider.dart';
import '../providers/theme_provider.dart';
import '../services/redirect.dart';
import '../widgets/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late ScrollController _listController;
  late FocusNode focusNode;

  var isListening = false;
  SpeechToText speechToText = SpeechToText();

  @override
  void initState() {
    _listController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BounceInDown(
          child: Text(
            'Ayumi',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AsistantPage(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Image(
                image: AssetImage('assets/images/virtualAssistant.png'),
                width: 40,
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      child: Image.asset(
                        'assets/images/ace.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          label: "Ayumi",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          label: "Your bot",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // ListTile(
              //   leading: Icon(
              //     Iconsax.user_edit,
              //     color: Theme.of(context).iconTheme.color,
              //   ),
              //   onTap: () async {
              //     RedirectURL().developerUrl();
              //   },
              //   title: const TextWidget(
              //     label: "Developer",
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              ListTile(
                leading: Icon(
                  IconlyLight.document,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () async {
                  RedirectURL().aboutUrl();
                },
                title: const TextWidget(
                  label: "About App",
                ),
              ),
              ListTile(
                leading: Icon(
                  Iconsax.danger,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () async {
                  RedirectURL().issueUrl();
                },
                title: const TextWidget(
                  label: "Report a problem",
                  fontWeight: FontWeight.w600,
                ),
              ),
              SwitchListTile(
                value: themeProvider.isChecked,
                onChanged: (bool value) {
                  themeProvider.changeTheme();
                },
                title: TextWidget(
                  label: themeProvider.isChecked == true
                      ? "Light Theme"
                      : "Dark Theme",
                ),
                secondary: themeProvider.isChecked == true
                    ? Icon(
                        Icons.light_mode_outlined,
                        color: Theme.of(context).iconTheme.color,
                      )
                    : Icon(
                        Icons.dark_mode,
                        color: Theme.of(context).iconTheme.color,
                      ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              controller: _listController,
              itemCount: chatProvider.getChatList.length, // chatList.length,
              itemBuilder: (context, index) {
                return ChatWidget(
                  msg: chatProvider
                      .getChatList[index].message, // chatList[index].message,
                  chatIndex: chatProvider.getChatList[index]
                      .chatIndex, // chatList[index].chatIndex,
                );
              },
            ),
          ),
          if (_isTyping) ...[
            const SpinKitThreeBounce(
              color: Colors.blue,
              size: 20,
            ),
          ],
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x29000000),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        style: const TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xff666666),
                        ),
                        controller: textEditingController,
                        onSubmitted: (value) async {
                          await sendMessage(
                            chatProvider: chatProvider,
                            modelsProvider: modelsProvider,
                          );
                        },
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Ask me anything...',
                          hintStyle: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color(0xff666666),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    AvatarGlow(
                      endRadius: 25,
                      animate: isListening,
                      glowColor: Colors.blue,
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      repeat: true,
                      duration: const Duration(milliseconds: 2000),
                      showTwoGlows: true,
                      child: GestureDetector(
                        onTap: () async {
                          if (!isListening) {
                            var available = await speechToText.initialize();
                            if (available) {
                              setState(() {
                                isListening = true;
                              });
                              speechToText.listen(
                                onResult: (result) {
                                  setState(() {
                                    textEditingController.text =
                                        result.recognizedWords;
                                    // sendMessage(
                                    //   chatProvider: chatProvider,
                                    //   modelsProvider: modelsProvider,
                                    // );
                                  });
                                  print('there');
                                  print(result.recognizedWords);
                                },
                              );
                            }
                          } else {
                            setState(() {
                              isListening = false;
                            });
                            sendMessage(
                              chatProvider: chatProvider,
                              modelsProvider: modelsProvider,
                            );
                            await speechToText.stop();
                          }
                        },
                        // onTapDown: (details) async {
                        //   if (!isListening) {
                        //     var available = await speechToText.initialize();
                        //     if (available) {
                        //       setState(() {
                        //         isListening = true;
                        //       });
                        //       speechToText.listen(
                        //         onResult: (result) {
                        //           setState(() {
                        //             textEditingController.text =
                        //                 result.recognizedWords;
                        //             sendMessage(
                        //               chatProvider: chatProvider,
                        //               modelsProvider: modelsProvider,
                        //             );
                        //           });
                        //           print('there');
                        //           print(result.recognizedWords);
                        //         },
                        //       );
                        //     }
                        //   }
                        // },
                        // onTapUp: (details) async {
                        //   setState(() {
                        //     isListening = false;
                        //   });
                        //   await speechToText.stop();
                        // },
                        child: Icon(
                          isListening
                              ? Iconsax.microphone_25
                              : Iconsax.microphone,
                          size: 30,
                          color: const Color(0xff215cec),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await sendMessage(
                          modelsProvider: modelsProvider,
                          chatProvider: chatProvider,
                        );
                      },
                      icon: const Icon(
                        size: 30,
                        Iconsax.send_15,
                        color: Color(0xff215cec),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      )),
    );
  }

  void scrollToBottom() {
    _listController.animateTo(
      _listController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMessage({
    required ModelsProvider modelsProvider,
    required ChatProvider chatProvider,
  }) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(label: "you can't send more than one message"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(label: "Please enter a message"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String message = textEditingController.text;
      setState(() {
        _isTyping = true;
        chatProvider.addUserChat(message: message);
        textEditingController.clear();
      });
      await chatProvider.sendMsg(
        message: message,
        modelId: modelsProvider.getCurrentModel,
      );
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(label: error.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        scrollToBottom();
        _isTyping = false;
      });
    }
  }
}
