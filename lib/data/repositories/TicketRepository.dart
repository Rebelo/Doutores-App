
import 'dart:convert';

import 'package:doutores_app/data/dataproviders/TicketDP.dart';
import 'package:doutores_app/data/models/TicketResponseModel.dart';
import '../models/TicketModel.dart';

class TicketRepository {

  static TicketResponse? createTicketResponse;
  static List<Ticket>? tickets;
  static List<Map> groupAccountants = [];
  static int totalUnread = 0;

  static Future<bool> createTicket(String subject, String message, int id) async {
    final response = await TicketDataProvider.createTicket(
        subject, message, id, 6840);

    if(response.statusCode == 200){
      createTicketResponse =
          TicketResponse.fromJson(jsonDecode(response.body));
      return true;
    }else {
      return false;
    }
  }

  static Future<bool> getTickets() async {

    final response = await TicketDataProvider.getTickets();

    if(response.statusCode == 200) {
        var tagObjsJsons = jsonDecode(response.body)['chats'] as List;

        var filtered = tagObjsJsons.where((i) => i['subject'] != null).toList();

        tickets = filtered.map((tagJson) => Ticket.fromJson(tagJson)).toList();

        totalUnread = jsonDecode(response.body)['totalUnread'];

      return true;
    }else {
      return false;
    }
  }


  static Future<bool> getCompanyGroups() async{

    groupAccountants = [];
    groupAccountants.add({0: ""});

    final response = await TicketDataProvider.getCompanyGroups();

    List<dynamic> myMap = json.decode(response.body);


    if(response.statusCode == 200) {

      for(final el in myMap){

        groupAccountants.add({el['id']: el['description']});

      }

      return true;
    }
    return false;

  }

}