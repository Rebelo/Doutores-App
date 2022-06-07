
import 'dart:convert';

import 'package:doutores_app/data/repositories/UserRepository.dart';
import 'package:http/http.dart' as http;
import '../../utils/Header.dart';


class FileDataProvider{

  static Future<http.Response> getFiles(String? id, String? startDate, String? endDate) async {
    return await http.post(
        Uri.https('api.osayk.com.br', 'api/Companies/GetCompanyDocumentsDrive'),
        body: jsonEncode({
          "companyToken": UserRepository.user.companyToken,
          "parentId": id,
          "startDate": startDate,
          "endDate": endDate,
          "fileName": "",
          "contentType": ""
        }),
        headers: Header.commonHeader()
    );
  }
}

