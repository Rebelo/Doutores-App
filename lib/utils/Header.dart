

import 'package:doutores_app/data/repositories/UserRepository.dart';

class Header {

  static Map<String, String> commonHeader(){
    return {
      'Accept-Language': 'en-US,en;q=0.9,pt;q=0.8',
      'Content-Type': 'application/json',
      'Authorization': 'Osayk ' + UserRepository.user.token, //todo
      'Origin': 'https://doutoresdacontabilidade.osayk.com.br',
      'Refer': 'https://doutoresdacontabilidade.osayk.com.br/',
      'Connection': 'keep-alive'
    };
  }

}

