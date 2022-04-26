
import 'dart:convert';


import 'package:http/http.dart' as http;

import '../../utils/Header.dart';
import '../models/NotificationModel.dart';



class NotificationRepository{

  static List<NotificationModel> notifications = [];
  static int notificationsCount = 0;



  static void addNotification(String date, String message){
    NotificationModel n = NotificationModel(date, message);
    notifications.add(n);
    notificationsCount++;
  }

  static void setCount(int num){
    notificationsCount = num;
  }

  static int getNewNotificationsCount(){
    return notificationsCount;
  }

  static Future<void> getUnpresented() async {


    final response = await http.get(
        Uri.https('api.osayk.com.br', 'api/notifications/GetUnpresented'),
        headers: Header.commonHeader()
    );

    List<dynamic> myMap = json.decode(response.body);
    myMap.forEach((element) {
      String x = element['message'].replaceAll("Drive", "sistema");
      String y = x.split(".")[0] + x.split(".")[1];
      String date = element['date'].split("T")[0];
      String time = element['date'].split("T")[1];
      String dateTime = time +" - "+ date.split("-")[2] +"/"+ date.split("-")[1] +"/"+ date.split("-")[0];


      addNotification(dateTime, y);
    });

  }

  static Future<void> markAsPresented() async {

    final response = await http.post(
        Uri.https('api.osayk.com.br', 'api/notifications/GetUnpresented'),
        headers: Header.commonHeader()

    );

    if (response.statusCode != 200){
      //HomeScreen.zeroCounter();
    }

  }
}





/*
[
{
"id": 128974,
"icon": "fa-calendar",
"date": "2022-03-31T05:17:03",
"message": "Encontra-se no Drive o boleto Declarac¸a~o_HU.pdf, com vencimento em 06/03/2024. Você pode encontra-lo em: /EXTRATOS BANCÁRIOS.",
"cssClass": "text-orange",
"description": "Drive"
}
]

https://api.osayk.com.br/api/notifications/GetUnpresented
Request Method: GET




https://api.osayk.com.br/api/notifications/MarkAsPresented
Request Method: POST

*/
