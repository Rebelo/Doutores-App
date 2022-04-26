
import 'dart:convert';

import 'package:http/http.dart' as http;

class BlogSamplePostDataProvider{

  static Future<dynamic> getLastPosts(String path) async {
    Map<String, String> headers = {"Accept": "text/html,application/xml"};
    var httpUri = Uri(
        scheme: 'https',
        host: 'doutoresdacontabilidade.com.br',
        path: path);
    return await http.get(httpUri, headers: headers);

  }

}

