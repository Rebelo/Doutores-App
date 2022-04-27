
import 'dart:convert';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class BlogSamplePostDataProvider{

  static Future<dynamic> getLastPosts(String path) async {
    Map<String, String> headers = {"Accept": "text/html,application/xml"};
    var httpUri = Uri(
        scheme: 'https',
        host: 'doutoresdacontabilidade.com.br',
        path: path);
    http.Response response =  await http.get(httpUri, headers: headers);

    try {
      if (response.statusCode == 200) {
        var data = parse(response.body);
        return data;
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }

  }

}

