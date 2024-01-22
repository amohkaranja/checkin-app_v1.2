import 'package:checkin/components/base_ui.dart';
import 'package:checkin/screens/otp_page1.dart';
import 'package:checkin/themes/app_theme.dart';
import 'package:checkin/utils/apis_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailValidation extends StatefulWidget {
  const EmailValidation({super.key});

  @override
  State<EmailValidation> createState() => _EmailValidationState();
}

class _EmailValidationState extends State<EmailValidation> {
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;
  String _errorMessage = "";
  final emailController = TextEditingController();

  bool _validateEmail(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = "";
      });
      var data = {
        "email": emailController.text,
      };
      post(
          data,
          "forgot_password.php",
          (result, error) => {
            print("out put of email==============>$result"),
                if (result == null)
                  {
                    setState(() {
                      _errorMessage = error;
                    }),
                  }
                else
                  {
                    saveEmail(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OTPValidation(
                                origin: "reset",
                              )),
                    )
                  }
              },
          context);
    }
  }

  saveEmail() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          toolbarHeight: 10,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                Container(
                  child: Image(image: AssetImage("assets/images/logo.png")),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: UI.text("Verify your to reset your password",
                      textAlign: TextAlign.center, fontStyle: FontStyle.italic),
                ),
                if (_errorMessage != "") ...[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: UI.text(_errorMessage,
                        textAlign: TextAlign.center, textColor: Colors.red),
                  )
                ],
                SizedBox(
                  height: 10,
                ),
                UI.formInput(
                    label: "Email address",
                    hint: "Email address",
                    controller: emailController,
                    validator: (value) {
                      if (!_validateEmail(value!)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    }),
                SizedBox(height: 30),
                UI.button(
                    text: "Submit",
                    onPressed: () {
                      onSubmit();
                    }),
                SizedBox(
                  height: 10,
                ),
              ]),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }
}
