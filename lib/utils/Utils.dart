

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

}