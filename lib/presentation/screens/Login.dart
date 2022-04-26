
//cvC79W76

import 'package:doutores_app/logic/cubits/user/UserCubit.dart';
import 'package:doutores_app/logic/cubits/user/UserState.dart';
import 'package:doutores_app/presentation/widgets/Alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:doutores_app/utils/APPColors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/APPConstants.dart';
import 'ForgetPassword.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  bool _showPassword = false;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailFocusNode.dispose();
    passWordFocusNode.dispose();
  }

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: APPColorPrimary,
        body: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is LoadedState){

            }
            if (state is ErrorState){
              Alerts.showError(context, "Não conseguimos fazer login", "Não conseguimos fazer login nesse momento, tente novamente ma", "ok", Icons.access_alarms);
            }
          },
          child: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 200),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  color: whiteColor,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: emailCont,
                          focusNode: emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu email';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(passWordFocusNode);
                          },
                          style: const TextStyle(color: blackColor),
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: APPDividerColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: APPColorPrimary)),
                            labelText: "E-mail",
                            labelStyle:
                            TextStyle(color: APPGreyColor, fontSize: 14),
                          ),
                        ),
                        TextFormField(
                          controller: passwordCont,
                          focusNode: passWordFocusNode,
                          obscureText: !_showPassword,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: blackColor),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite sua senha';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Senha",
                            labelStyle:
                            const TextStyle(color: APPGreyColor, fontSize: 14),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: APPColorPrimary,
                                  size: 20),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: APPDividerColor)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: APPColorPrimary)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              const BHForgotPasswordScreen().launch(context);
                            },
                            child: const Text('Esqueceu sua senha?',
                                style: TextStyle(
                                    color: APPTextColorSecondary,
                                    fontSize: 14)),
                          ),
                        ),
                        16.height,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              primary: APPColorSecondary,
                            ),

                            onPressed: () {
                              BlocProvider.of<UserCubit>(context).login(emailCont.text, passwordCont.text);
                            },

                            child: const Text(
                              BtnSend,
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        16.height,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
