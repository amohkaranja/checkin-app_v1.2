import 'package:checkin/components/base_ui.dart';
import 'package:checkin/components/ui/buttons_ui.dart';
import 'package:checkin/components/ui/input_action.dart';
import 'package:checkin/themes/app_theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  UI.formInput(
                      hint: "Email address", controller: usernameController),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      UI.linkText("", "Forgot Password?",
                          onPressed: () {}, textColor: AppTheme.secondaryColor)
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
                  UI.button(text: "Login", onPressed: () {}),
                  SizedBox(
                    height: 10,
                  ),
                  UI.text("Don't have an account?"),
                  UI.linkText("", "click here to register",
                      onPressed: () {}, textColor: AppTheme.secondaryColor)
                ]),
              ),
              Positioned(
                child: UI.buttonLC(
                    icon: Icons.message,
                    onPressed: () {},
                    sizeType: ButtonSizeType.small),
                bottom: 0,
                right: 0,
              )
            ]),
          ),
        ));
  }
}
