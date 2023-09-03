// ignore_for_file: avoid_print
import 'package:checkin2/screens/email_validation.dart';
import 'package:checkin2/screens/otp_page.dart';
import 'package:checkin2/screens/user_signUp.dart';
import 'package:checkin2/screens/student_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/apis_list.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _loading=false;
  late String _username = "", _password = "";
  String _errorMessage = "";
    sendOtp() async{
     final prefs = await SharedPreferences.getInstance();
     var  studentId= prefs.getString("student_id")!;
     var data={"student_id":studentId};
     var url="resend_student_email.php";
      post(data, url, (result,error)=>{
         if (result == null)
          {
                  setState(() {
                  _loading=false;
                  _errorMessage = error;
                }),
              }
              else
                {

                  setState(() {
                  _loading=false;
                  
                }),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OtpPage(origin: "reset")),
                  )
                }
      });
   
  }
  submit() {
    setState(() {
      _errorMessage = "";
      _loading=true;
    });
    var data = {"email": _username, "password": _password};
   
       login(
        data,
        (result, error) => {
              if (result == null)
                {
                  setState(() {
                  _loading=false;
                }),
                  setState(() {
                    _errorMessage = "Invalid username or password!";
                  })
                }
              else
                {
                    setState(() {
                  _loading=false;
                }),
                if(result=="2"){
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OtpPage(origin: "new_user",)),
                  )
                }else{
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentHomeScreen()),
                  )
                }
                 
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _errorMessage != ""
                ? Container(
                    height: 20,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(),
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      "$_errorMessage",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : Container(height: 1),
             
                
            TextFormField(
              initialValue: "",
              decoration: InputDecoration(
                // labelStyle:  Theme.of(context).textTheme.bodySmall,
                fillColor: Theme.of(context).primaryColorLight,
                  labelText: 'Username',   
                   labelStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black // Light mode text color
                    : Colors.white, // Dark mode text color
              ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    gapPadding: 10.0,
                  ),
                  ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a username';
                }else{
                  setState(() {
                    _username=value;
                  });
                  return null;
                }
                
              },
              onSaved: (value) => _username = value!,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              initialValue: "",
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    gapPadding: 10.0,
                  )),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                }else{
                  setState(() {
                    _password=_password;
                  });
                  return null;
                }
                
              },
              onSaved: (value) => _password = value!,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).focusColor,
              ),
              onPressed: () {
               
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  FocusScope.of(context).unfocus();
                   submit();
                  // Use _username and _password to log in
                }
              },
              child: const Text('Log in'),
            ),
            Center(
              child: SizedBox(
                child: Column(
                  children: <Widget>[
                     Text("Do you have an account?",style: Theme.of(context).textTheme.bodyMedium,),
                   Builder(
  builder: (context) => GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserSignUp()),
      );
    },
    child: const Text(
      "click here to register",
      style: TextStyle(color: Colors.blue),
    ),
  ),
),                 Builder(
  builder: (context) => GestureDetector(
    onTap: () {
        Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmailValidation()),
                  );
    },
    child: const Text(
      "Forgot password?",
      style: TextStyle(color: Colors.red),
    ),
  ),
)
                  ],
                ),
              ),
            ),
          _loading?  Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children:  [
      CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).focusColor), 
      ), 
      SizedBox(height: 8),
      Text(
        'Loading...',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    ],
  ),
):Container()

          ],
        ),
      ),
    );
  }
}
