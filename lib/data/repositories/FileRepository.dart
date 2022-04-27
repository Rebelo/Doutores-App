
import 'dart:convert';

import 'package:doutores_app/data/repositories/UserRepository.dart';
import 'package:http/http.dart' as http;

import 'package:doutores_app/data/models/FileModel.dart';
import '../../utils/Header.dart';
import '../../utils/Utils.dart';

class FileRepository{

  static List<File> files = [];

  static Future<void> getFiles() async {

    files = [];

    //INSS
    final response = await http.post(
        Uri.https('api.osayk.com.br', 'api/Companies/GetCompanyDocumentsDrive'),
        body: jsonEncode({
          "companyToken": UserRepository.user.companyToken,
          "parentId":296081,
          "startDate":null,
          "endDate":null,
          "fileName":"",
          "contentType":""
        }),
        headers: Header.commonHeader()
    );

    List<dynamic> decodedResponseBody = json.decode(response.body);
    decodedResponseBody.forEach((element) {
      String x = element['referenceDate'].split(" ")[0].split("/")[2];
      addFile(
          element['downloadToken'],
          "DARF - Previdenciário",
          element['dueDate'].split("/")[0],
          Utils.numToMonth(element['dueDate'].split("/")[1]),
          element['referenceDate'].split(" ")[0].split("/")[2],
          element['referenceDate'].split(" ")[0].split("/")[1],
          "DARF",
          element['value']
      );
    });

  }

  static void addFile(String urlPath, String name, String dia, String mes, String referenceYear, String referenceMonth, String type, String value){
    File f = File(urlPath, name, dia, mes, referenceYear, referenceMonth, type, value);
    files.add(f);
  }

}

