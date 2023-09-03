import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:checkin/screens/login_page.dart';
import 'package:checkin/screens/registered_classes.dart';
import 'package:checkin/screens/scanned_classes.dart';
import 'package:checkin/screens/security_edit.dart';
import 'package:checkin/screens/student_home.dart';
import 'package:checkin/utils/apis_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.home,
     title: 'Home',
  ),

  TabItem(
    icon: Icons.account_box,
    title: 'profile',
  ),
];

class User_Profile extends StatefulWidget {
  const User_Profile({super.key});

  @override
  State<User_Profile> createState() => _User_ProfileState();
}

class _User_ProfileState extends State<User_Profile> {
 Profile? _profile; 
  int _currentIndex = 1;
Map<String, dynamic> result = {"scan":0,"register":0};
  @override
void initState() {
  super.initState();
  loadProfileData();
   _currentIndex = 1;
  }
    void _navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => StudentHomeScreen()),
    );
  }

Future<void>logout() async{
   final prefs = await SharedPreferences.getInstance();
   prefs.remove('regNo');
  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
}

  Future<void> loadProfileData() async {
  final profile = await profileData();
  final _result = await fetch_Scanned_Registered();
  print(_result);
   setState(() {
      _profile = profile; // assign the value of profile to _profile
      result=_result;
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
       leading: IconButton(icon: Icon(Icons.arrow_back_sharp),onPressed: (){
          _navigateToHomePage();
        },),
        title: const Text(
          "My Profile",
          style: TextStyle(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Theme.of(context).focusColor,
      ),
      body: SingleChildScrollView(
        child: Column(children:<Widget> [
           
           Container(
             
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0,),
                child: Container(
                  height: 140,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Theme.of(context).focusColor,width: 2.0),
                      ),
                  child: const Image(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(child: Column(children:  <Widget>[
              Text(_profile?.first_name ?? '', style:  Theme.of(context).textTheme.bodyMedium),
              Text(_profile?.email?? '', style:  Theme.of(context).textTheme.bodySmall),
              Text(_profile?.regNo??'', style:  Theme.of(context).textTheme.bodySmall),
              Text(_profile?.phone_number?? '', style:  Theme.of(context).textTheme.bodySmall),
            ]),),
          ),
     
      Card(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                      fetchRegisteredClasses().then((result) {
                          if (result is RegisteredClasses) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => result),
                            );
                          } else if (result is String) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result)),
                            );
                          }
                        }).catchError((error) {
                          print(error);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: ${error.toString()}")),
                          );
                        });
                        },
                      child: Column(
                                children: [
                                  Text("Classes Registered",style: Theme.of(context).textTheme.bodySmall),
                                  Text(result['register'].toString())
                                ],
                              ),
                    ),GestureDetector(
                        onTap: () {
                    fetchScannedClasses().then((result) {
                          if (result is ScannedClasses) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => result),
                            );
                          } else if (result is String) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result)),
                            );
                          }
                        }).catchError((error) {
                          print(error);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: ${error.toString()}")),
                          );
                        });

                        },
                      child: Column(
                                children:  [
                                  Text("Classes signed",style: Theme.of(context).textTheme.bodySmall),
                                  Text(result['scan'].toString())
                                ],
                              ),
                    )
                  ],
                  )),
        ),
      ),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            child: Row(
              children: [
                const Image(
                        image: AssetImage("assets/images/edit.png"),
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0,),
                        child: GestureDetector(
                           onTap: () {
                    //       Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => Account_Edit()),
                    // );
                        },
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                            Text("Account",style: TextStyle(fontWeight: FontWeight.w600),),
                            Text("Edit personal information",style: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic))
                          ],),
                        ),
                      )
              ],
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            child: GestureDetector(
                 onTap: () {
                          Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()),
                    );
                        },
              child: Row(
                children: [
                  const Image(
                          image: AssetImage("assets/images/key.png"),
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0,),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                            Text("Security",style: TextStyle(fontWeight: FontWeight.w600),),
                            Text("Change password",style: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic))
                          ],),
                        )
                ],
              ),
            ),
          ), Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            child: Row(
              children: [
                const Image(
                        image: AssetImage("assets/images/acknowledgement.png"),
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0,),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                          
                          Text("Acknowledgement",style: TextStyle(fontWeight: FontWeight.w600),),
                          Text("Public testers and appreciation list",style: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic))
                        ],),
                      )
              ],
            ),
          ),  Card(child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(children:  <Widget>[
                  Expanded(child: Center(child: Text("Check-In V 1.0"))),
                
                  GestureDetector(
                    onTap: () {
                      logout();
                    },
                    child: Image(image: AssetImage("assets/images/exit.png"),
                                height: 40,
                              ),
                  )],),
          )),
          
        ],
      )
        ]),
      ),
            bottomNavigationBar: Container(
        padding:const EdgeInsets.symmetric(vertical: 0),
        child: BottomBarFloating(
          items: items,
          backgroundColor: Theme.of(context).focusColor,
           color: Colors.white,
          colorSelected: Colors.orange,
          indexSelected:  _currentIndex ,
          paddingVertical: 20,
          onTap: (int index) => setState(() {
                _currentIndex = index;
               print(index);
            if (index == 0) {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StudentHomeScreen()),
                    );
            } else if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const User_Profile()),
                    );
            }
          }),
        ),
      ),
    );
  }
}
