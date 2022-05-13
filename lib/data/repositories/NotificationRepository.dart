
import 'dart:convert';


import 'package:http/http.dart' as http;

import '../../utils/Header.dart';
import '../dataproviders/NotificationDP.dart';
import '../models/NotificationModel.dart';



class NotificationRepository{

  static List<NotificationModel> notifications = [];


  static Future<void> getUnpresented() async {

    notifications = [ ];

    final response = await NotificationDataProvider.getUnpresented();

    List<dynamic> myMap = json.decode(response.body);
    for (var element in myMap) {
      String x = element['message'].replaceAll("Drive", "sistema");
      String message = x.split(".")[0] + x.split(".")[1];
      String date = element['date'].split("T")[0];
      String time = element['date'].split("T")[1];
      String dateTime = time +" - "+ date.split("-")[2] +"/"+ date.split("-")[1] +"/"+ date.split("-")[0];

      NotificationModel n = NotificationModel(dateTime, message);
      notifications.add(n);
    }

  }

  static Future<void> markAsPresented() async {

    final response = await http.post(
        Uri.https('api.osayk.com.br', 'api/notifications/MarkAsPresented'),
        headers: Header.commonHeader()

    );

    if (response.statusCode != 200){
      //todo
    }


  }

  static void addNotification(String date, String message){
    NotificationModel n = NotificationModel(date, message);
    notifications.add(n);
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
