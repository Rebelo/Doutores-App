
import 'package:flutter/material.dart';
import '../Widgets/Alerts.dart';
import '../Widgets/Buttons.dart';
import '../../utils/APPColors.dart';
import '../../utils/APPConstants.dart';
import 'package:nb_utils/nb_utils.dart';


class BHForgotPasswordScreen extends StatefulWidget {
  static String tag = '/ForgotPasswordScreen';

  const BHForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  BHForgotPasswordScreenState createState() => BHForgotPasswordScreenState();
}

final _formKey = GlobalKey<FormState>();

class BHForgotPasswordScreenState extends State<BHForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: APPColorPrimary,
        body: Stack(
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
                              borderSide: BorderSide(color: APPDividerColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: APPDividerColor)),
                          labelText: "E-mail",
                          labelStyle:
                              TextStyle(color: APPGreyColor, fontSize: 14),
                        ),
                      ),
                      16.height,
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Buttons.width_button(() async {
                          if (_formKey.currentState!.validate()) {
/*
                            var response = await Login.post_forgot_password(emailController.text);

                            Map jsonData = jsonDecode(response.body);

                            Alert.showError(context, "teste", "teste", "teste", Icons.warning);

                            if (jsonData['result'] == "Success") {
                              finish(context);
                              const LoginScreen().launch(context);

                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Email não cadastrado no nosso sistema.')));
                            }*/
                          }

                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
