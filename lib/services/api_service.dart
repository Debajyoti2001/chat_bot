// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:chatbot/constants/apikey.dart';
import 'package:http/http.dart' as http;

import '../models/chat_model.dart';
import '../models/models_model.dart';

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("https://api.openai.com/v1/models"),
        headers: {'Authorization': 'Bearer ${API.ApiKey}'},
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }
      //print("response $jsonResponse");
      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
        log("temp${value['id']}");
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      print("error $error");
      rethrow;
    }
  }

  // send message using to api (model)
  static Future<List<ChatModel>> sendMessageGPT({
    required String message,
    required String modelId,
  }) async {
    try {
      log(modelId);
      var response = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          'Authorization': 'Bearer ${API.ApiKey}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(
          {
            "model": modelId,
            "messages": [
              {
                "role": "user",
                "content": message,
              }
            ]
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        // log("jsonResponse['choices']['text'] ${jsonResponse['choices'][0]['text']}");
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) {
            return ChatModel(
              message: jsonResponse['choices'][index]['message']['content'],
              chatIndex: 1,
            );
          },
        );
      }
      return chatList;
    } catch (error) {
      print("error $error");
      rethrow;
    }
  }

  // send message to api
  static Future<List<ChatModel>> sendMessage({
    required String message,
    required String modelId,
  }) async {
    try {
      log(modelId);
      var response = await http.post(
        Uri.parse("https://api.openai.com/v1/completions"),
        headers: {
          'Authorization': 'Bearer ${API.ApiKey}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(
          {
            "model": modelId,
            "prompt": message,
            "max_tokens": 4000,
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        // log("jsonResponse['choices']['text'] ${jsonResponse['choices'][0]['text']}");
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) {
            return ChatModel(
              message: jsonResponse['choices'][index]['text'],
              chatIndex: 1,
            );
          },
        );
      }
      return chatList;
    } catch (error) {
      print("error $error");
      rethrow;
    }
  }
}
