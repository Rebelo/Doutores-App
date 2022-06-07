import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/Header.dart';


class NotificationDataProvider{

  static Future<http.Response> getUnpresented() async {

    return await http.get(
        Uri.https('api.osayk.com.br', 'api/notifications/GetUnpresented'),
        headers: Header.commonHeader()
    );

  }

  static Future<http.Response> markAsPresented() async {

    return await http.post(
        Uri.https('api.osayk.com.br', 'api/notifications/MarkPresented'),
        headers: Header.commonHeader()
    );

  }
}