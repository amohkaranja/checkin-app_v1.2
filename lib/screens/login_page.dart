import 'package:checkin/screens/email_validation.dart';
import 'package:checkin/screens/otp_page1.dart';
import 'package:checkin/screens/student_home1.dart';
import 'package:checkin/screens/student_regiter.dart';
import 'package:flutter/material.dart';
import 'package:checkin/components/base_ui.dart';
import 'package:checkin/components/ui/buttons_ui.dart';
import 'package:checkin/components/ui/input_action.dart';
import 'package:checkin/screens/otp_page.dart';
import 'package:checkin/screens/student_home.dart';
import 'package:checkin/themes/app_theme.dart';
import 'package:checkin/utils/apis_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;
  String _errorMessage = "";
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
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
        "email": usernameController.text,
        "password": passwordController.text
      };

      login(
          data,
          context,
          (result, error) => {
                if (result == null)
                  {
                    setState(() {}),
                    setState(() {
                      _errorMessage = "Invalid username or password!";
                    })
                  }
                else
                  {
                    setState(() {}),
                    if (result == "2")
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OTPValidation(
                                    origin: "new_user",
                                  )),
                        )
                      }
                    else
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentHomePage()),
                        )
                      }
                  }
              });
    }
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
            child: Stack(children: [
              Form(
                key: _formKey,
                child: Column(children: [
                  Container(
                    child: Image(image: AssetImage("assets/images/logo.png")),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: UI.text(
                        "Fill in the form with your email and password to login",
                        textAlign: TextAlign.center,
                        fontStyle: FontStyle.italic),
                  ),
                  if (_errorMessage != "") ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: UI.text(_errorMessage,
                          textAlign: TextAlign.center, textColor: Colors.red),
                    )
                  ],
                  SizedBox(
                    height: 10,
                  ),
                  UI.formInput(
                      hint: "Email address",
                      controller: usernameController,
                      validator: (value) {
                        if (!_validateEmail(value!)) {
                          return "Please enter a valid email address";
                        }
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      UI.linkText("", "Forgot Password?", onLinkTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmailValidation()),
                        );
                      }, textColor: AppTheme.secondaryColor)
                    ],
                  ),
                  UI.formInput(
                      hint: "Password",
                      controller: passwordController,
                      isPassword: obscure,
                      inputAction: InputAction(
                          icon:
                              obscure ? Icons.visibility : Icons.visibility_off,
                          callback: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          })),
                  SizedBox(height: 30),
                  UI.button(
                      text: "Login",
                      onPressed: () {
                        onSubmit();
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  UI.text("Don't have an account?"),
                  UI.linkText(
                    "",
                    "click here to register",
                    onLinkTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentRegistration()),
                      );
                    },
                    textColor: AppTheme.secondaryColor,
                  ),
                ]),
              ),
              Positioned(
                child: UI.buttonLC(
                    icon: Icons.message,
                    onPressed: () {},
                    sizeType: ButtonSizeType.small),
                bottom: 0,
                right: 0,
              ),
            ]),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
}
