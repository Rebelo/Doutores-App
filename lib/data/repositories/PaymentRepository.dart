
import 'dart:convert';

import 'package:doutores_app/data/dataproviders/UserDP.dart';
import 'package:doutores_app/data/models/PaymentModel.dart';
import 'package:doutores_app/data/repositories/UserRepository.dart';
import 'package:http/http.dart' as http;
import '../../utils/Header.dart';
import '../../utils/Utils.dart';
import '../dataproviders/PaymentDP.dart';

class PaymentRepository{

  static List<Payment> pagamentosList = [];


  static Future<bool> getPayments() async {

    pagamentosList = [];
    final response = await PaymentDataProvider.getPayments();

    if(response.statusCode != 200){
      return false;
    }

    try {
      final parsedJson = json.decode(response.body);
      final bills = parsedJson['bills'];
      if(bills == null) return true;
      for (var bill in bills) {
        var stringValue = bill['value'].toString().replaceAll(".", ",");
        addToList(
          bill['id'],
          bill['name'],
          bill['dueDateDesc'].split("/")[2],
          Utils.numToMonth(bill['dueDateDesc'].split("/")[1]),
          bill['dueDateDesc'].split("/")[0],
          bill['description'],
          stringValue.split(",")[1].length == 2 ? stringValue : stringValue +
              "0",
          bill['status'],
          bill['detailsUrl'],
        );
      }
    } catch(e){
      return false;
    }

    return true;

  }


  //this.id, this.dueDate, this.name, this.payDate, this.dueDateDesc, this.description, this.value, this.status, this.issueDateDesc
  static void addToList(String? id, String? name, String? ano, String? mes, String? dia, String? description, String? value, String? status, String? urlPath){
    pagamentosList.add(
        Payment(id, name, ano, mes,dia, description, value, status, urlPath)
    );
  }

}