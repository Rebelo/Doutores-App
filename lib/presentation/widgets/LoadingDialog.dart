import 'package:flutter/material.dart';

class LoadingDialog {

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: const EdgeInsets.all(0.0),
          insetPadding: const EdgeInsets.symmetric(horizontal: 100),
          content: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: Colors.blueAccent),
                const SizedBox(height: 16),
                Text("Aguarde....", style: TextStyle(color: Colors.black.withOpacity(0.6)),),
              ],
            ),
          ),
        );
      },
    );
  }

  static Container showLittleLoading() {
    return Container(
      alignment: Alignment.center,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(
          backgroundColor: Color(0xffD6D6D6),
          strokeWidth: 4,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
        ),
      ),
    );
  }

}