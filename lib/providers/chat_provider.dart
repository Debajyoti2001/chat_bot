
import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../services/api_service.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  addUserChat({required String message}) {
    chatList.add(ChatModel(
      message: message,
      chatIndex: 0,
    ));
    notifyListeners();
  }

  // send message to api
  Future<void> sendMsg({
    required String message,
    required String modelId,
  }) async {
    if (modelId.toLowerCase().startsWith('gpt')) {
      chatList.addAll(
        await ApiService.sendMessageGPT(
          message: message,
          modelId: modelId,
        ),
      );
    } else {
      chatList.addAll(
        await ApiService.sendMessage(
          message: message,
          modelId: modelId,
        ),
      );
      notifyListeners();
    }
  }
}
