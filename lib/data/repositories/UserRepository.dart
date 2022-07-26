
import 'dart:convert';


import '../dataproviders/UserDP.dart';
import '../models/UserModel.dart';

class UserRepository{

  static User user = User();

  static Future<String> login(String _email, String pass) async {

    var response = await UserDataProvider.postLogin(_email, pass);

    final parsedJson = jsonDecode(response.body);

    if(parsedJson['result'] != "Success"){
      return parsedJson['result'];
    }

    final userInfo = parsedJson['userInfo'];
    var email = "";
    var email2 = "";

    if(userInfo['userName'].length > 18){
      email = userInfo['userName'].split("@")[0];
      email2 = "@" + userInfo['userName'].split("@")[1];
    }else {
      email = userInfo['userName'];
      email2 = "";
    }

    user.token = parsedJson['token'];
    user.id = userInfo['id'];
    user.name = userInfo['name'];
    user.email = email;
    user.emailCompl = email2;

    return parsedJson['result'];
  }

  static Future<bool> getLastAccess() async {
    final response = await UserDataProvider.getLastAccess();

    final parsedJson = json.decode(response.body)[0];
    user.companyToken = parsedJson['token'];
    user.isBlock = parsedJson['isBlock'];
    user.notificatonCounter = parsedJson['numberNotificationsToAccountant'];

    if(response.statusCode == 200){
      return true;
    }else {
      return false;
    }

  }


  static Future<int> askNewPassword(String email) async {
    var response = await UserDataProvider.postForgotPassword(email);

    return response.statusCode;

  }

}