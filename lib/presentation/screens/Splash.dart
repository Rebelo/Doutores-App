import 'dart:async';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Login.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  BHSplashScreenState createState() => BHSplashScreenState();
}

class BHSplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    Timer(const Duration(seconds: 3), () {
      finish(context);
      const LoginScreen().launch(context);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/images/logo_brain.svg',
            height: 120,
            width: 120,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF102F5B),
                Color(0xFF102F5B),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
