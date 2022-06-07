
import 'dart:convert';

import 'package:http/http.dart';

import '../dataproviders/MessageDP.dart';
import '../models/MessageModel.dart';


class MessagesRepository{

  static late List<Message> messagesList;

  static void addMessageObj(Message element){
    //messagesList.insert(0, element);
    messagesList.add(element);
  }

  static Future<bool> sendFile(String path, int id) async {

    try {
      final response = await MessageDataProvider.sendFile(id, path);
      if(response.statusCode == 200){
        return true;
      }else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<Response> sendMessage(String message, int id) async {

    return await MessageDataProvider.sendMessage(message, id);

  }

  static Future<bool> getMessages(int? id) async {
    final response = await MessageDataProvider.getMessages(id);

    if(response.statusCode == 200){

      List objsJson = jsonDecode(response.body)['messages'] as List;

      messagesList = objsJson.map((tagJson) => Message.fromJson(tagJson)).toList();

      return true;
    }else {
      return false;
    }
  }

}