
import 'dart:convert';
import 'dart:io' as IO;
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

import 'package:doutores_app/data/repositories/UserRepository.dart';
import 'package:http/http.dart' as http;
import '../../utils/Header.dart';

class MessageDataProvider{

  static Future<Response<dynamic>> sendFile(int? id, String path) async {

    IO.File file = IO.File(path);
    //Uint8List bin = file.readAsBytesSync();

    var formData = FormData.fromMap({
      'companyToken': UserRepository.user.companyToken,
      'messageId': id.toString(),
      'file': await MultipartFile.fromFile(path, filename: basename(file.path))
    });

    var dio = Dio();
    dio.options.headers['Origin'] = 'https://doutoresdacontabilidade.osayk.com.br';
    dio.options.headers['Refer'] = 'https://doutoresdacontabilidade.osayk.com.br/';
    dio.options.headers["Authorization"] = 'Osayk ' + UserRepository.user.token;
    return await dio.post('https://api.osayk.com.br/api/mailbox/upload', data: formData);

  }

  static Future<http.Response> sendMessage(String? message, int? id) async {
    return await http.post(
      Uri.https('api.osayk.com.br', 'api/mailbox/ReplyTicket'),
      headers: Header.commonHeader(),
      body: jsonEncode(<String, dynamic>{
        "companyToken": UserRepository.user.companyToken,
        "message": message,
        "subdomain": UserRepository.user.subdomain,
        "ticketId": id
      }),
    );
  }

  static Future<http.Response> getMessages(int? id) async {
    return await http.post(
      Uri.https('api.osayk.com.br', 'api/mailbox/LoadTicket'),
      headers: Header.commonHeader(),
      body: jsonEncode(<String, dynamic>{
        "companyToken": UserRepository.user.companyToken,
        "id": id
      }),
    );
  }

}


