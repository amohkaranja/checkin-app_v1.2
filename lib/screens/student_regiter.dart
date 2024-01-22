import 'package:checkin/components/base_ui.dart';
import 'package:checkin/components/ui/buttons_ui.dart';
import 'package:checkin/components/ui/input_action.dart';
import 'package:checkin/screens/login_page.dart';
import 'package:checkin/themes/app_theme.dart';
import 'package:checkin/utils/apis_list.dart';
import 'package:flutter/material.dart';

class StudentRegistration extends StatefulWidget {
  const StudentRegistration({super.key});

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;
  bool confirmobscure = true;
  String _errorMessage = "";
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final regNoController = TextEditingController();
  bool _validateEmail(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  void onSubmit() {
    setState(() {
      _errorMessage = "";
    });
    if (_formKey.currentState!.validate()) {
      var data = {
        "firstname": firstNameController.text,
        "lastname": lastNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "phone": "+254${phoneNumberController.text.replaceAll(' ', '')}",
        "regNo": regNoController.text,
      };
      post(
          data,
          "student_register.php",
          (result, error) => {
                if (result == null)
                  {
                    setState(() {
                      _errorMessage = error;
                    }),
                  }
                else
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    )
                  }
              },
          context);
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
                    child: UI.text("Fill in the form to register",
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
                      label: "First name",
                      hint: "First name",
                      controller: firstNameController),
                  UI.formInput(
                      label: "Last name",
                      hint: "Last name",
                      controller: lastNameController),
                  UI.formInput(
                      label: "Email address",
                      hint: "Email address",
                      controller: emailController,
                      validator: (value) {
                        if (!_validateEmail(value!)) {
                          return "Please enter a valid email address";
                        }
                      }),
                  UI.phoneInput(
                      hint: "Phone no", controller: phoneNumberController),
                  UI.formInput(
                      label: "Reg no",
                      hint: "Reg no",
                      controller: regNoController),
                  UI.formInput(
                      hint: "Password",
                      label: "Password",
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
                  UI.formInput(
                      hint: " Confirm Password",
                      label: "Confirm Password",
                      controller: confirmPasswordController,
                      isPassword: confirmobscure,
                      validator: (value) {
                        if (passwordController.text != value) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      inputAction: InputAction(
                          icon:
                              confirmobscure ? Icons.visibility : Icons.visibility_off,
                          callback: () {
                            setState(() {
                              confirmobscure = !confirmobscure;
                            });
                          })),
                  SizedBox(height: 10),
                  UI.button(
                      text: "REGISTER",
                      onPressed: () {
                        onSubmit();
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  UI.text("Already have an account?"),
                  UI.linkText("", "click here to login", onLinkTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }, textColor: AppTheme.secondaryColor),
                  SizedBox(
                    height: 100,
                  ),
                ]),
              ),
              Positioned(
                child: UI.buttonLC(
                    icon: Icons.message,
                    onPressed: () {},
                    sizeType: ButtonSizeType.small),
                bottom: 120,
                right: 0,
              )
            ]),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();

    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    regNoController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
