import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/AppWidget.dart';
import '../../utils/APPColors.dart';

class Alerts {

  static void noInternetError(context){
    showError(context, "Sem Conexão", "Verifique sua conexão à internet", "ok", Icons.signal_wifi_connected_no_internet_4);
  }

  static void showError(BuildContext context, String title, String description, String buttonTitle, IconData icon) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.cardColor,
        content: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(height: 120, color: APPColorPrimary),
                  Column(
                    children: [
                      Icon(icon, color: white, size: 32),
                      8.height,
                      Text(title, textAlign: TextAlign.center,
                          style: boldTextStyle(color: white, size: 18)),
                    ],
                  )
                ],
              ),
              30.height,
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                    description, style: secondaryTextStyle()),
              ),
              16.height,
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: boxDecoration(
                      bgColor: APPColorPrimary, radius: 10),
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: text(buttonTitle, textColor: white, fontSize: 16.0),
                ),
              ),
              16.height,
            ],
          ),
        ),
        contentPadding: const EdgeInsets.all(0),
      ),
    );
  }
}
