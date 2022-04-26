

import 'dart:convert';

import 'package:doutores_app/data/endpoints.dart';
import 'package:http/http.dart' as http;

import 'package:doutores_app/utils/Header.dart';

class UserDataProvider {

  static Future<http.Response> postLogin(String email, String pass) async {
    return await http.post(
      Uri.https('api.osayk.com.br', endpoints.LOGIN_FORM),
      headers: Header.commonHeader(),
      body: jsonEncode(<String, String>{
        'username': email,
        'password': pass,
        'subdomain': 'doutoresdacontabilidade'
      }),
    );
  }

  static Future<http.Response> postForgotPassword(String email) async {
    return await http.post(
      Uri.https('api.osayk.com.br', 'api/Registration/RemindPassword'),
      headers: Header.commonHeader(),
      body: jsonEncode(<String, String>{
        'email': email,
        'subdomain': 'doutoresdacontabilidade'
      }),
    );
  }

  static Future<http.Response> getLastAccess() async {
    return await http.get(
        Uri.https('api.osayk.com.br', endpoints.LAST_ACCESS),
        headers: Header.commonHeader()
    );


  }
}