import 'package:doutores_app/logic/cubits/user/UserCubit.dart';
import 'package:doutores_app/presentation/Screens/Home.dart';
import 'package:doutores_app/presentation/screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cubits/notification/NotificationCubit.dart';
import 'screens/Splash.dart';



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
  final NotificationCubit _notificationsCubit = NotificationCubit();
  final UserCubit _userCubit = UserCubit();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home' :  (context) => BlocProvider.value(
          value: _notificationsCubit,
          child: const HomeScreen()
        ),
        '/' : (context) => BlocProvider.value(
          value: _userCubit,
          child: const LoginScreen()
        ),
      },
    );
  }

  @override
  void dispose(){
    _notificationsCubit.close();
    _userCubit.close();
    super.dispose();
  }
}
  
