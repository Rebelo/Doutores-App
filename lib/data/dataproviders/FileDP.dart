
import 'dart:convert';

import 'package:doutores_app/data/repositories/UserRepository.dart';
import 'package:http/http.dart' as http;
import '../../utils/Header.dart';


class FileDataProvider{
  //INSS

  Future<http.Response> getInssFiles() async {
    return await http.post(
        Uri.https('api.osayk.com.br', 'api/Companies/GetCompanyDocumentsDrive'),
        body: jsonEncode({
          "companyToken": UserRepository.user.token,
          "parentId": 296081,
          "startDate": null,
          "endDate": null,
          "fileName": "",
          "contentType": ""
        }),
        headers: Header.commonHeader()
    );
  }
}
