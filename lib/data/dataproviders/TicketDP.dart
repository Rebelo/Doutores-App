
import 'dart:convert';

import 'package:doutores_app/data/repositories/UserRepository.dart';
import 'package:http/http.dart' as http;
import '../../utils/Header.dart';

class TicketDataProvider{

  static Future<http.Response> createTicket(String? subject, String? message, int? groupId, int? agentId) async {
    return await http.post(
      Uri.https('api.osayk.com.br', 'api/mailbox/CreateTicket'),
      headers: Header.commonHeader(),
      body: jsonEncode(<String, dynamic>{
        "companyToken": UserRepository.user.companyToken,
        "subject": subject,
        "message": message,
        "groupId": groupId,
        "subdomain": UserRepository.user.subdomain,
        "agentId": agentId
      }),
    );
  }

  static Future<http.Response> getTickets() async {
    return await http.post(
      Uri.https('api.osayk.com.br', 'api/mailbox/GetChats'),
      headers: Header.commonHeader(),
      body: jsonEncode(<String, dynamic>{
        "companyToken": UserRepository.user.companyToken
      }),
    );
  }

  static Future<http.Response> getCompanyGroups() async {
    return await http.post(
      Uri.https('api.osayk.com.br', 'api/mailbox/GetCompanyGroups'),
      headers: Header.commonHeader(),
      body: jsonEncode(<String, dynamic>{
        "subdomain": UserRepository.user.subdomain,
      }),
    );
  }

}