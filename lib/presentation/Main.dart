
import 'package:doutores_app/logic/cubits/user/UserCubit.dart';
import 'package:doutores_app/logic/cubits/forgot_password/ForgotPasswordCubit.dart';


import 'package:doutores_app/presentation/screens/Blog.dart';

import 'package:doutores_app/presentation/screens/ForgetPassword.dart';
import 'package:doutores_app/presentation/Screens/Home.dart';
import 'package:doutores_app/presentation/screens/Login.dart';
import 'package:doutores_app/presentation/screens/Notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final UserCubit _userCubit = UserCubit();
  final ForgotPasswordCubit _forgetPasswordCubit = ForgotPasswordCubit();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        '/' : (context) => BlocProvider.value(
            value: _userCubit,
            child: const LoginScreen()
        ),

        '/home' :  (context) => const HomeScreen(),

        '/forgot' : (context) => BlocProvider.value(
            value: _forgetPasswordCubit,
            child: const ForgotPasswordScreen()
        ),

        '/notification' : (context) => const NotificationScreen(),

        '/blog' : (context) => const BlogScreen()


      },
    );
  }

  @override
  void dispose(){
    _userCubit.close();
    super.dispose();
  }
}
  
