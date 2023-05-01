import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  OtpFieldController otpController = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text(
          "OTP screen",
          style: TextStyle(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),
        ),
        backgroundColor: const Color(0xff008346),
      ),
      body: 
      SingleChildScrollView(
        child: Column(
          children: [
              Container(
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3))
                    ]),
                child: const Image(
                  height:120,
                  image: AssetImage("assets/images/logo_jpg.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Text("Email Validation",style: TextStyle(fontWeight: FontWeight.bold)),
                Image(
                  height:120,
                  image: AssetImage("assets/images/email.png"),
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60,vertical: 20),
                  child: Text("An email was sent to your address to confirm on its validity and" 
                  "ownership. Please enter the 6-digit code sent to validate your account",style: TextStyle(fontStyle: FontStyle.italic)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Text("gathaiya28@gmail.com",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue))),
            Center(
              child: OTPTextField(
                  controller: otpController,
                  length: 5,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 45,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 15,
                  style: TextStyle(fontSize: 17),
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  }),
            ),
            SizedBox(height: 20),
               ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff008346),
              ),
              onPressed: () {
             
              },
              child: const Text('Resend Email'),
            ),
            Padding(
              child: Column(
                children: [
                  Text("Not your email?",style: TextStyle(color: Colors.red),),
                   Text("Click here to change account",style: TextStyle(color: Colors.red),)
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 10,
            
            )
            )
          ],
        ),
      ),
    );
  }
}