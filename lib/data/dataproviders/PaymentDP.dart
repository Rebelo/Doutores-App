



import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../utils/Header.dart';
import '../repositories/UserRepository.dart';


class PaymentDataProvider{

  Future<http.Response> getPagamentos() async {
    return await http.post(
      Uri.https('api.osayk.com.br', 'api/Companies/GetPaymentInfoProfile'),
      headers: Header.commonHeader(),
      body: jsonEncode(<String, String>{
        'companyToken': UserRepository.user.companyToken,
        'subdomain': UserRepository.user.subdomain
      }),
    );

  }

}