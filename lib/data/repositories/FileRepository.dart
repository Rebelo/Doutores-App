
import 'dart:convert';

import 'package:doutores_app/data/repositories/UserRepository.dart';
import 'package:http/http.dart' as http;

import 'package:doutores_app/data/models/FileModel.dart';
import '../../utils/Header.dart';
import '../../utils/Utils.dart';
import '../dataproviders/FileDP.dart';

class FileRepository{

  static List<File> otherFiles = [];
  static List<File> impostos = [];

  static Future<bool> getImpostos() async {
    impostos = [];

    String inssId = "",
        fgtsId = "",
        outrosImpostosId = "",
        impostosId = "";
    try{
      // PRIMEIRAS PASTAS
      dynamic response = await FileDataProvider.getFiles(null, null, null);
      if (response.statusCode != 200) {
        return false;
      }

      List<dynamic> firstDecodedResponseBody = json.decode(response.body);
      for (var element in firstDecodedResponseBody) {
        if (element['name'] == "IMPOSTOS") {
          impostosId = element['id'];
        }
      }

      // SEGUNDO NÍVEL
      response = await FileDataProvider.getFiles(impostosId, null, null);
      if (response.statusCode != 200) {
        return false;
      }

      List<dynamic> secondDecodedResponseBody = json.decode(response.body);
      for (var element in secondDecodedResponseBody) {
        switch (element['name']) {
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
      response = await FileDataProvider.getFiles(inssId, null, null);
      if (response.statusCode != 200) {
        return false;
      }

      List<dynamic> decodedResponseBody = json.decode(response.body);
      for (var element in decodedResponseBody) {
        if (element['type'] != "dir") {
          addFile(
              impostos,
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
      response = await FileDataProvider.getFiles(fgtsId, null, null);
      if (response.statusCode != 200) {
        return false;
      }

      decodedResponseBody = json.decode(response.body);
      for (var element in decodedResponseBody) {
        if (element['type'] != "dir") {
          addFile(
              impostos,
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
      response = await FileDataProvider.getFiles(outrosImpostosId, null, null);
      if (response.statusCode != 200) {
        return false;
      }

      decodedResponseBody = json.decode(response.body);
      for (var element in decodedResponseBody) {
        if (element['type'] != "dir") {
          addFile(
              impostos,
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
  } catch(e){
      return false;
    }

    return true;
  }

  static Future<bool> getOtherFiles() async {

    otherFiles = [];

    String certDigId = "", folhaId = "", notasFiscaisId = "";

    // PRIMEIRAS PASTAS
    try{

      dynamic response = await FileDataProvider.getFiles(null, null, null);
      if (response.statusCode != 200) {
        return false;
      }

      List<dynamic> firstDecodedResponseBody = json.decode(response.body);
      for (var element in firstDecodedResponseBody) {
        switch(element['name']){
          case "FOLHA | PRÓ-LABORE":
            folhaId = element['id'];
            break;
          case "CERTIFICADO DIGITAL":
            certDigId = element['id'];
            break;
          case "Notas Fiscais":
            notasFiscaisId = element['id'];
            break;
        }
      }

      //CERT DIG
      response = await FileDataProvider.getFiles(certDigId, null, null);
      if (response.statusCode != 200) {
        return false;
      }

      List<dynamic> decodedResponseBody = json.decode(response.body);
      for (var element in decodedResponseBody) {
        if(element['type'] != "dir") {
          addFile(
              otherFiles,
              element['downloadToken'],
              "Certificado Digital",
              element['dueDate'].split("/")[0],
              Utils.numToMonth(element['dueDate'].split("/")[1]),
              element['referenceDate'].split(" ")[0].split("/")[2],
              element['referenceDate'].split(" ")[0].split("/")[1],
              "Cert. Digital",
              element['value'],
              element['dueDate']
          );
        }
      }


      //FOLHA
      response = await FileDataProvider.getFiles(folhaId, null, null);
      if (response.statusCode != 200) {
        return false;
      }

      decodedResponseBody = json.decode(response.body);
      for (var element in decodedResponseBody) {
        if(element['type'] != "dir") {
          addFile(
              otherFiles,
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


      //NOTASFISCAIS
      response = await FileDataProvider.getFiles(notasFiscaisId, null, null);
      if (response.statusCode != 200) {
        return false;
      }

      decodedResponseBody = json.decode(response.body);
      for (var element in decodedResponseBody) {
        if(element['type'] != "dir") {
          addFile(
              otherFiles,
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

    } catch(e){
      return false;
    }

    return true;
  }

  static void addFile(List<File> list, String urlPath, String name, String dia, String mes, String referenceYear, String referenceMonth, String type, String value, String dueDate){

    String dueDateFormated = dueDate.split(" ")[0].replaceAll("/","-");

    File f = File(urlPath, name, dia, mes, referenceYear, referenceMonth, type, value, dueDateFormated);
    list.add(f);
  }

}

