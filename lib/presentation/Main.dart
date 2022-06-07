
import 'package:doutores_app/logic/cubits/files/OtherFilesCubit.dart';
import 'package:doutores_app/logic/cubits/messages/GetMessagesCubit.dart';
import 'package:doutores_app/logic/cubits/messages/SendMessagesCubit.dart';
import 'package:doutores_app/logic/cubits/notification/NotificationCubit.dart';
import 'package:doutores_app/logic/cubits/tickets/CreateTicketCubit.dart';
import 'package:doutores_app/logic/cubits/user/UserCubit.dart';
import 'package:doutores_app/logic/cubits/forgot_password/ForgotPasswordCubit.dart';

import 'package:doutores_app/presentation/screens/Blog.dart';
import 'package:doutores_app/presentation/screens/Chat.dart';
import 'package:doutores_app/presentation/screens/File.dart';

import 'package:doutores_app/presentation/screens/ForgetPassword.dart';
import 'package:doutores_app/presentation/Screens/Home.dart';
import 'package:doutores_app/presentation/screens/Login.dart';
import 'package:doutores_app/presentation/screens/NewTicket.dart';
import 'package:doutores_app/presentation/screens/Notifications.dart';
import 'package:doutores_app/presentation/screens/Payments.dart';
import 'package:doutores_app/presentation/screens/Tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubits/blog/BlogPostsCubit.dart';
import '../logic/cubits/files/ImpostosCubit.dart';
import '../logic/cubits/payments/PaymentCubit.dart';
import '../logic/cubits/tickets/TicketsCubit.dart';


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
  final NotificationCubit _notificationCubit = NotificationCubit();
  final ImpostosCubit _impostosCubit = ImpostosCubit();
  final PaymentCubit _paymentCubit = PaymentCubit();
  final BlogPostsCubit _blogPostsCubit = BlogPostsCubit();
  final OtherFilesCubit _otherFilesCubit = OtherFilesCubit();
  final SendMessagesCubit _sendMessagesCubit = SendMessagesCubit();
  final SendFileCubit _sendFileCubit = SendFileCubit();
  final GetMessagesCubit _getMessagesCubit = GetMessagesCubit();
  final CreateTicketCubit _createTicketCubit = CreateTicketCubit();
  final TicketsCubit _ticketsCubit = TicketsCubit();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {

        '/' :  (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _userCubit,
              ),
              BlocProvider.value(
                value: _impostosCubit,
              ),
              BlocProvider.value(
                value: _paymentCubit,
              ),
              BlocProvider.value(
                value: _blogPostsCubit,
              ),
              BlocProvider.value(
                  value: _notificationCubit
              ),
              BlocProvider.value(
                  value: _ticketsCubit
              )
            ],
            child: const LoginScreen()
        ),

        '/blog': (context) => const BlogScreen(),

        '/home' :  (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _impostosCubit,
              ),
              BlocProvider.value(
                value: _paymentCubit,
              ),
              BlocProvider.value(
                value: _blogPostsCubit,
              ),
              BlocProvider.value(
                  value: _notificationCubit
              ),
              BlocProvider.value(
                  value: _ticketsCubit
              )
            ],
            child: const HomeScreen()
        ),

        '/payment' : (context) => BlocProvider.value(
            value: _paymentCubit,
            child: const PaymentsScreen()
        ),

        '/forgot' : (context) => BlocProvider.value(
            value: _forgetPasswordCubit,
            child: const ForgotPasswordScreen()
        ),

        '/notification' : (context) => BlocProvider.value(
            value:_notificationCubit,
            child: const NotificationScreen()
        ),

        '/newTicket' : (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _ticketsCubit,
              ),
              BlocProvider.value(
                value: _createTicketCubit,
              ),
            ],
            child: const NewTicketScreen()
        ),



        '/tickets' : (context) => BlocProvider.value(
            value: _ticketsCubit,
            child: const TicketsScreen()
        ),

        '/chat': (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _getMessagesCubit,
              ),
              BlocProvider.value(
                value: _sendMessagesCubit,
              ),
              BlocProvider.value(value: _sendFileCubit)
            ],
            child: const ChatScreen()
        ),

        '/files':  (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _impostosCubit,
              ),
              BlocProvider.value(
                value: _otherFilesCubit,
              ),
            ],
            child: const FileScreen()
        ),

      },
    );
  }

  @override
  void dispose(){
    _userCubit.close();
    _forgetPasswordCubit.close();
    _notificationCubit.close();
    _impostosCubit.close();
    _paymentCubit.close();
    _blogPostsCubit.close();
    _otherFilesCubit.close();
    _sendMessagesCubit.close();
    _sendFileCubit.close();
    _getMessagesCubit.close();
    _createTicketCubit.close();
    _ticketsCubit.close();
    super.dispose();
  }
}
  
