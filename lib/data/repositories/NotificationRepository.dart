
import 'dart:convert';


import 'package:http/http.dart' as http;

import '../../utils/Header.dart';
import '../dataproviders/NotificationDP.dart';
import '../models/NotificationModel.dart';



class NotificationRepository{

  static List<NotificationModel> notifications = [];


  static Future<bool> getUnpresented() async {

    notifications = [];

    try {
      final response = await NotificationDataProvider.getUnpresented();

      if(response.statusCode != 200) return false;

      List<dynamic> myMap = json.decode(response.body);
      for (var element in myMap) {
        String x = element['message'].replaceAll("Drive", "sistema");
        String message = x.split(".")[0] + x.split(".")[1];
        String date = element['date'].split("T")[0];
        String time = element['date'].split("T")[1];
        String dateTime = time + " - " + date.split("-")[2] + "/" +
            date.split("-")[1] + "/" + date.split("-")[0];

        NotificationModel n = NotificationModel(dateTime, message);
        notifications.add(n);
      }
      return true;

    } catch(e){
      return false;
    }

  }

  static Future<void> markAsPresented() async {

    final response = await NotificationDataProvider.markAsPresented();

    if (response.statusCode != 200){
      //todo
    }

  }

}


