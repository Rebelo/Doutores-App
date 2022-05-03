
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

    String inssId = "", fgtsId = "", outrosImpostosId = "", certDigId = "", folhaId = "", notasFiscaisId = "", impostosId = "";

    // PRIMEIRAS PASTAS

    dynamic response = await http.post(
        Uri.https('api.osayk.com.br', 'api/Companies/GetCompanyDocumentsDrive'),
        body: jsonEncode({
          "companyToken": UserRepository.user.companyToken,
          "parentId":null,
          "startDate":null,
          "endDate":null,
          "fileName":"",
          "contentType":""
        }),
        headers: Header.commonHeader()
    );

    List<dynamic> firstDecodedResponseBody = json.decode(response.body);
    for (var element in firstDecodedResponseBody) {
      switch(element['name']){
        case "FOLHA | PRÓ-LABORE":
          folhaId = element['id'];
          break;
        case "CERTIFICADO DIGITAL":
          certDigId = element['id'];
          break;
        case "NOTAS FISCAIS":
          notasFiscaisId = element['id'];
          break;
        case "IMPOSTOS":
          impostosId = element['id'];
          break;
      }
    }

    // SEGUNDO NÍVEL

    response = await http.post(
        Uri.https('api.osayk.com.br', 'api/Companies/GetCompanyDocumentsDrive'),
        body: jsonEncode({
          "companyToken": UserRepository.user.companyToken,
          "parentId":impostosId,
          "startDate":null,
          "endDate":null,
          "fileName":"",
          "contentType":""
        }),
        headers: Header.commonHeader()
    );

    List<dynamic> secondDecodedResponseBody = json.decode(response.body);
    for (var element in secondDecodedResponseBody) {
      switch(element['name']){
        case "OUTROS IMPOSTOS | TAXAS":
          outrosImpostosId = element['id'];
          break;
        case "FGTS":
          fgtsId = element['id'];
          break;
        case "INSS":
          inssId = element['id'];
          break;
      }
    }



    //INSS
    response = await http.post(
        Uri.https('api.osayk.com.br', 'api/Companies/GetCompanyDocumentsDrive'),
        body: jsonEncode({
          "companyToken": UserRepository.user.companyToken,
          "parentId":inssId,
          "startDate":null,
          "endDate":null,
          "fileName":"",
          "contentType":""
        }),
        headers: Header.commonHeader()
    );

    List<dynamic> decodedResponseBody = json.decode(response.body);
    for (var element in decodedResponseBody) {
      if(element['type'] != "dir") {
        addFile(
            element['downloadToken'],
            "DARF - Previdenciário",
            element['dueDate'].split("/")[0],
            Utils.numToMonth(element['dueDate'].split("/")[1]),
            element['referenceDate'].split(" ")[0].split("/")[2],
            element['referenceDate'].split(" ")[0].split("/")[1],
            "DARF",
            element['value'],
            element['dueDate']
        );
      }
    }

    //FGTS
    response = await http.post(
        Uri.https('api.osayk.com.br', 'api/Companies/GetCompanyDocumentsDrive'),
        body: jsonEncode({
          "companyToken": UserRepository.user.companyToken,
          "parentId":fgtsId,
          "startDate":null,
          "endDate":null,
          "fileName":"",
          "contentType":""
        }),
        headers: Header.commonHeader()
    );

    decodedResponseBody = json.decode(response.body);
    for (var element in decodedResponseBody) {
      if(element['type'] != "dir") {
        addFile(
            element['downloadToken'],
            "FGTS",
            element['dueDate'].split("/")[0],
            Utils.numToMonth(element['dueDate'].split("/")[1]),
            element['referenceDate'].split(" ")[0].split("/")[2],
            element['referenceDate'].split(" ")[0].split("/")[1],
            "FGTS",
            element['value'],
            element['dueDate']
        );
      }
    }

    //OUTROS_IMPOSTOS
    response = await http.post(
        Uri.https('api.osayk.com.br', 'api/Companies/GetCompanyDocumentsDrive'),
        body: jsonEncode({
          "companyToken": UserRepository.user.companyToken,
          "parentId":outrosImpostosId,
          "startDate":null,
          "endDate":null,
          "fileName":"",
          "contentType":""
        }),
        headers: Header.commonHeader()
    );

    decodedResponseBody = json.decode(response.body);
    for (var element in decodedResponseBody) {
      if(element['type'] != "dir") {
        addFile(
            element['downloadToken'],
            "Simples Nacional | Taxas",
            element['dueDate'].split("/")[0],
            Utils.numToMonth(element['dueDate'].split("/")[1]),
            element['referenceDate'].split(" ")[0].split("/")[2],
            element['referenceDate'].split(" ")[0].split("/")[1],
            "Simples",
            element['value'],
            element['dueDate']
        );
      }
    }

    //CERT DIG
    /*
    response = await http.post(
        Uri.https('api.osayk.com.br', 'api/Companies/GetCompanyDocumentsDrive'),
        body: jsonEncode({
          "companyToken": UserRepository.user.companyToken,
          "parentId":certDigId,
          "startDate":null,
          "endDate":null,
          "fileName":"",
          "contentType":""
        }),
        headers: Header.commonHeader()
    );

    decodedResponseBody = json.decode(response.body);
    for (var element in decodedResponseBody) {
      if(element['type'] != "dir") {
        addFile(
            element['downloadToken'],
            "Certificado Digital",
            element['dueDate'].split("/")[0],
            Utils.numToMonth(element['dueDate'].split("/")[1]),
            element['referenceDate'].split(" ")[0].split("/")[2],
            element['referenceDate'].split(" ")[0].split("/")[1],
            "Cert Digital",
            element['value'],
            element['dueDate']
        );
      }
    }
    */

    //FOLHA
    /*
    response = await http.post(
        Uri.https('api.osayk.com.br', 'api/Companies/GetCompanyDocumentsDrive'),
        body: jsonEncode({
          "companyToken": UserRepository.user.companyToken,
          "parentId":folhaId,
          "startDate":null,
          "endDate":null,
          "fileName":"",
          "contentType":""
        }),
        headers: Header.commonHeader()
    );

    decodedResponseBody = json.decode(response.body);
    for (var element in decodedResponseBody) {
      if(element['type'] != "dir") {
        addFile(
            element['downloadToken'],
            "Folha | Prolabore",
            element['dueDate'].split("/")[0],
            Utils.numToMonth(element['dueDate'].split("/")[1]),
            element['referenceDate'].split(" ")[0].split("/")[2],
            element['referenceDate'].split(" ")[0].split("/")[1],
            "Folha",
            element['value'],
            element['dueDate']
        );
      }
    }
    */

    //NOTASFISCAIS
    /*
    response = await http.post(
        Uri.https('api.osayk.com.br', 'api/Companies/GetCompanyDocumentsDrive'),
        body: jsonEncode({
          "companyToken": UserRepository.user.companyToken,
          "parentId":notasFiscaisId,
          "startDate":null,
          "endDate":null,
          "fileName":"",
          "contentType":""
        }),
        headers: Header.commonHeader()
    );

    decodedResponseBody = json.decode(response.body);
    for (var element in decodedResponseBody) {
      if(element['type'] != "dir") {
        addFile(
            element['downloadToken'],
            "Notas Fiscais",
            element['dueDate'].split("/")[0],
            Utils.numToMonth(element['dueDate'].split("/")[1]),
            element['referenceDate'].split(" ")[0].split("/")[2],
            element['referenceDate'].split(" ")[0].split("/")[1],
            "Notas",
            element['value'],
            element['dueDate']
        );
      }
    }
    */

  }

  static void addFile(String urlPath, String name, String dia, String mes, String referenceYear, String referenceMonth, String type, String value, String dueDate){
    String dueDateFormated = dueDate.split(" ")[0].replaceAll("/","-");
    File f = File(urlPath, name, dia, mes, referenceYear, referenceMonth, type, value, dueDateFormated);
    files.add(f);
    /*files.sort((a, b){ //sorting in descending order
      return DateTime.parse(b.dueDate!).compareTo(DateTime.parse(a.dueDate!));
    });*/
  }

}

