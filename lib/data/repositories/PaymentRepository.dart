

import 'dart:convert';

import 'package:doutores_app/data/dataproviders/UserDP.dart';
import 'package:doutores_app/data/models/PaymentModel.dart';
import 'package:doutores_app/data/repositories/UserRepository.dart';
import 'package:http/http.dart' as http;
import '../../utils/Header.dart';
import '../../utils/Utils.dart';



class PaymentRepository{

  static List<Payment> pagamentosList = [];


  //this.id, this.dueDate, this.name, this.payDate, this.dueDateDesc, this.description, this.value, this.status, this.issueDateDesc
  static void addToList(String? id, String? name, String? ano, String? mes, String? dia, String? description, String? value, String? status, String? urlPath){
    pagamentosList.add(
        Payment(id, name, ano, mes,dia, description, value, status, urlPath)
    );
  }


  static Future<void> get_payments() async {
    final response = await http.post(
      Uri.https('api.osayk.com.br', 'api/Companies/GetPaymentInfoProfile'),
      headers: Header.commonHeader(),
      body: jsonEncode(<String, String>{
        'companyToken': UserRepository.user.companyToken,
        'subdomain': UserRepository.user.subdomain
      }),
    );


    final parsedJson = json.decode(response.body);
    final bills = parsedJson['bills'];
    for(var i = 0; i < bills.length; i++){
      var bill = bills[i];
      var stringValue = bill['value'].toString().replaceAll(".", ",");
      addToList(
        bill['id'],
        bill['name'],
        bill['dueDateDesc'].split("/")[2],
        Utils.numToMonth(bill['dueDateDesc'].split("/")[1]),
        bill['dueDateDesc'].split("/")[0],
        bill['description'],
        stringValue.split(",")[1].length == 2 ? stringValue : stringValue+"0",
        bill['status'],
        bill['detailsUrl'],
      );
    }



  }


}