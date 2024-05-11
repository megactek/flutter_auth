import 'package:auth_app/models/register_request_model.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../config.dart';
import '../services/api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;
  String? email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: HexColor('#283B71'),
          body: ProgressHUD(
            child: Form(
              key: globalFormKey,
              child: _registerUI(context),
            ),
            inAsyncCall: isApiCallProcess,
            opacity: .3,
            key: UniqueKey(),
          )),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white],
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/ShoppingAppLogo.png',
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              'Register',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
          FormHelper.inputFieldWidget(
            context,
            'username',
            'Username',
            (onValidate) {
              if (onValidate.isEmpty) {
                return 'Username cannot be empty';
              }
              return null;
            },
            (onSaved) {
              username = onSaved;
            },
            prefixIcon: Icon(Icons.person),
            prefixIconColor: Colors.white,
            borderFocusColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.7),
            borderRadius: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              'email',
              'Email',
              (onValidate) {
                if (onValidate.isEmpty) {
                  return 'Email cannot be empty';
                }
                return null;
              },
              (onSaved) {
                email = onSaved;
              },
              prefixIcon: Icon(Icons.mail),
              prefixIconColor: Colors.white,
              borderFocusColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(context, 'password', 'Password',
                (onValidate) {
              if (onValidate.isEmpty) {
                return 'Password cannot be empty';
              }
              return null;
            }, (onSaved) {
              password = onSaved;
            },
                prefixIcon: Icon(Icons.person),
                prefixIconColor: Colors.white,
                borderFocusColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
                obscureText: hidePassword,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    color: Colors.white.withOpacity(0.7),
                    icon: Icon(hidePassword
                        ? Icons.visibility
                        : Icons.visibility_off))),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              'Register',
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });
                  RegisterRequestModel register = RegisterRequestModel(
                      username: username!, password: password!, email: email!);
                  APIService.register(register).then((response) {
                    setState(() {
                      isApiCallProcess = false;
                    });
                    if (response.data != null) {
                      FormHelper.showSimpleAlertDialog(context, Config.appName,
                          'Registration successful', 'Ok', () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      });
                    } else {
                      FormHelper.showSimpleAlertDialog(
                          context, Config.appName, response.message!, 'Ok', () {
                        Navigator.pop(context);
                      });
                    }
                  });
                }
              },
              btnColor: HexColor('#283B71'),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'OR',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'Already have an account? '),
                    TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/');
                          })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
