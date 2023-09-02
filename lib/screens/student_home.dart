import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:checkin2/models/user_model.dart';
import 'package:checkin2/screens/class_instance.dart';
import 'package:checkin2/screens/class_scan.dart';
import 'package:checkin2/screens/class_scanII.dart';
import 'package:checkin2/screens/generate_code.dart';
import 'package:checkin2/screens/registered_classes.dart';
import 'package:checkin2/screens/scanned_classes.dart';
import 'package:flutter/material.dart';
import '../utils/apis_list.dart';
import 'user_profile.dart';

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
class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
   int _currentIndex = 0;
void initState(){
  super.initState();
    _currentIndex = 0;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My QR Code",
          style: TextStyle(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),
        ),
        backgroundColor: const Color(0xff008346),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
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
        
           Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(boxShadow: [
              
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 0.5,
                blurRadius: 3,
              )
            ]),
            child: Center(
              child: GestureDetector(
                 onTap: () {
                          Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassScanII()),
                    );
                        },
                child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                        child: Column(children: const <Widget>[
                          Image(
                            image: AssetImage("assets/images/qr_code_black.png"),
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                          Text("Scan Class")
                        ]),
                      ),
                    ),
                ),
              ),
            ),
            
          ),
               Container(
                margin: const EdgeInsets.symmetric(horizontal: 8,vertical:5),
                 child: Row(
                         children: [
                           Expanded(
                             child: Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 0.5,
                                    blurRadius: 3,
                                  )
                                ]),
                                  child: GestureDetector(
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
                                    child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(30.0),
                                            child: Column(children: const <Widget>[
                                                                      Image(
                                                                        image: AssetImage("assets/images/chalk_board.png"),
                                                                        height: 80,
                                                                        fit: BoxFit.contain,
                                                                      ),
                                                                      Text("Registered class")
                                                       ]),
                                          ),
                                                
                                               ),
                                  ),
                             ),
                           ),
                           Expanded(
                             child: Container(
                                           decoration: BoxDecoration(boxShadow: [
                                             BoxShadow(
                                               color: Colors.grey.shade300,
                                               spreadRadius: 0.5,
                                               blurRadius: 3,
                                             )
                                           ]),
                                             child: GestureDetector(
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
                                               child: Card(
                                                     child: Padding(
                                                       padding: const EdgeInsets.all(30.0),
                                                       child: Column(children: const <Widget>[
                                                                                 Image(
                                                                                   image: AssetImage("assets/images/time_machine.png"),
                                                                                   height: 80,
                                                                                   fit: BoxFit.contain,
                                                                                 ),
                                                                                 Text("Scanned Activities")
                                                       ]),
                                                     ),
                                               ),
                                             ),
                             ),
                           ),
                         ],
                       ),
               ),
                    Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(boxShadow: [
              
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 0.5,
                blurRadius: 3,
              )
            ]),
            child: Center(
              child: GestureDetector(
                onTap: () {
                          Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GenerateCode()),
                    );
                },
                child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                        child: Column(children: const <Widget>[
                          Image(
                            image: AssetImage("assets/images/blue_qr_code.png"),
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                          Text("Generate my QR Code")
                        ]),
                      ),
                    ),
                ),
              ),
            ),
            
          ),
        ]),
        
      ),
       bottomNavigationBar: Container(
        padding:const EdgeInsets.symmetric(vertical: 0),
        child: BottomBarFloating(
          items: items,
          backgroundColor: const Color(0xff008346),
          color: Colors.white,
          colorSelected: Colors.orange,
          indexSelected:  _currentIndex ,
          paddingVertical: 20,
          onTap: (int index) => setState(() {
                _currentIndex = index;
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
      )
    );
  }
}