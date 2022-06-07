
import 'package:doutores_app/logic/cubits/forgot_password/ForgotPasswordCubit.dart';
import 'package:doutores_app/logic/cubits/forgot_password/ForgotPasswordState.dart';
import 'package:doutores_app/presentation/screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Widgets/Alerts.dart';
import '../../utils/APPColors.dart';
import '../../utils/APPConstants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../widgets/LoadingDialog.dart';


class ForgotPasswordScreen extends StatefulWidget {
  static String tag = '/ForgotPasswordScreen';

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  BHForgotPasswordScreenState createState() => BHForgotPasswordScreenState();
}

final _formKey = GlobalKey<FormState>();

class BHForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: APPColorPrimary,
        body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if(state is NoInternetState){
              Alerts.noInternetError(context);
            }
            else if(state is LoadingState){
              LoadingDialog.showLoadingDialog(context);
            }
            else if (state is LoadedState){
              finish(context);
              const LoginScreen().launch(context);
            }
            else if (state is ErrorState){
              Alerts.showError(context, "Falha", "Não conseguimos pedir uma nova senha, tente novamente mais tarde", "ok", Icons.access_alarms);
            }
            else if (state is WrongEmailState){
              Alerts.showError(context, "Falha", "Email não cadastrado no sistema", "ok", Icons.access_alarms);
            }
          },
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    finish(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: whiteColor),
                ),
              ),
              Positioned(
                top: 70,
                child: Form(
                  key: _formKey,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      color: whiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(ForgotPwd,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: APPTextColorPrimary)),
                        16.height,
                        const Text(ForgotPasswordSubTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: APPTextColorSecondary, fontSize: 14)),
                        8.height,
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: blackColor),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu e-mail';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: APPBackGroundColor2)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: APPBackGroundColor2)),
                            labelText: "E-mail",
                            labelStyle:
                                TextStyle(color: APPGreyColor, fontSize: 14),
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
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<ForgotPasswordCubit>(context).ask(emailController.text);
                              }

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
