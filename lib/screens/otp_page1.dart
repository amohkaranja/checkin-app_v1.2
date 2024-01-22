import 'dart:async';

import 'package:checkin/components/base_ui.dart';
import 'package:checkin/screens/email_validation.dart';
import 'package:checkin/screens/login_page.dart';
import 'package:checkin/screens/reset_password.dart';
import 'package:checkin/screens/student_home.dart';
import 'package:checkin/themes/app_theme.dart';
import 'package:checkin/utils/apis_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPValidation extends StatefulWidget {
  const OTPValidation({super.key,required this.origin});
final String origin;

  @override
  State<OTPValidation> createState() => _OTPValidationState();
}

class _OTPValidationState extends State<OTPValidation> {
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = "";
  String studentId = "";
  final otpController = OtpFieldController();
  String otp = "";
  String email = "";
  var _timer;
  bool _isRequestingOTP = false;
  int _countdown = 60;

  Future<void> loaduserdata() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      studentId = prefs.getString("student_id")!;
      otp = prefs.getString("email_validation")!;
      email = prefs.getString("email")!;
    });
  }
  Future<void> _setTimer() async{
_timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_countdown > 0) {
          setState(() {
            _countdown--;
          });
        } else {
          _timer.cancel();
          _isRequestingOTP = false;
        }
      });
  }
void  resendOtp(){
     var data={"student_id":studentId};
     var url="resend_student_email.php";
      post(data, url, (result,error)=>{
          if(result==null){
          _errorMessage="Request failed due to server error. Please try again later",
          }
      },context);
   _setTimer();
  }
  void submit(String pin) {
      setState(() {
       _errorMessage="";
      });
    if(pin==otp){
     var data={"student_id":studentId};
     var url="validate_student_account.php";
      post(data, url, (result,error)=>{
          if(result==null){
          _errorMessage="Request failed due to server error. Please try again later",
          }else{
            if(widget.origin=="reset"){
               Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPassword()),
                  )
            }else{
               Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentHomeScreen()),
                  )
            }
             
          }
      },context);
    }else{
      setState(() {
        _errorMessage="Invalid OTP. Please try again later";
      });
    }
  }
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      loaduserdata();
      _setTimer();
    });
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
                  child: UI.text(
                      "An OTP has been sent to your email '$email'. Please verify your identity by entering the code",
                      textAlign: TextAlign.center,
                      fontStyle: FontStyle.italic),
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
                  height: 40,
                ),
                OTPTextField(
                    controller: otpController,
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 45,
                    fieldStyle: FieldStyle.box,
                    outlineBorderRadius: 15,
                    style: TextStyle(fontSize: 17),
                    onChanged: (pin) {
                      //  setState(() {
                      //       error="";
                      //     });
                    },
                    onCompleted: (pin) {
                      submit(pin);
                      print("Changed: " + pin);
                    }),
                SizedBox(
                  height: 30,
                ),
                UI.button(
                    text: _countdown > 0 ? '$_countdown seconds' : 'Resend OTP',
                    onPressed: () {
                               if (!_isRequestingOTP) {
                    setState(() {
                       _isRequestingOTP = true;
                       _countdown=60;
                     });
                  resendOtp();
        }
                    }),
                         SizedBox(
                  height: 30,
                ),
                UI.text("Don't have an account?"),
                UI.linkText(
                  "",
                  "Click here to change account",
                  onLinkTap: () async {
                      clearUser();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen()),
                    );
                  },
                  textColor: AppTheme.secondaryColor,
                ),
              ]),
            ),
          ),
        ));
  }
   
}
