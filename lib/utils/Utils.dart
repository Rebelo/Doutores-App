

import 'package:connectivity_plus/connectivity_plus.dart';

class Utils {

  static String numToMonth(String num){
    String ret = "";
    switch (num) {
      case "01":
        ret = "Jan";
        break;
      case "02":
        ret = "Fev";
        break;
      case "03":
        ret = "Mar";
        break;
      case "04":
        ret = "Abr";
        break;
      case "05":
        ret = "Mai";
        break;
      case "06":
        ret = "Jun";
        break;
      case "07":
        ret = "Jul";
        break;
      case "08":
        ret = "Ago";
        break;
      case "09":
        ret = "Set";
        break;
      case "10":
        ret = "Out";
        break;
      case "11":
        ret = "Nov";
        break;
      case "12":
        ret = "Dez";
        break;
    }
    return ret;
  }

  static String getDefaultDate(String strDate, {int sum = 0}){

    String date = strDate.split("T")[0];
    String time = strDate.split("T")[1];

    String day = date.split("-")[2];
    String month = date.split("-")[1];
    String year = date.split("-")[0].substring(2);

    int int_hour = int.parse(time.split(":")[0]);
    String hour = (int_hour+sum).toString();
    String minute = time.split(":")[1];

    return hour+":"+minute+" - "+day+"/"+month+"/"+year;

  }

  static Future<bool> isConnected() async{

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
       return true;
    } else {
      return false;
    }

  }

}