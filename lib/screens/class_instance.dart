import 'package:checkin2/screens/student_home.dart';
import 'package:flutter/material.dart';
import 'package:checkin2/models/user_model.dart';

import '../utils/apis_list.dart';
class ClassInstance extends StatefulWidget {
  const ClassInstance({
    Key? key,
    required this.model,
    required this.stdId,
    required this.qrData,
  }) : super(key: key);

  final ClassModel model;
  final String stdId;
  final String qrData;

  @override
  _ClassInstanceState createState() => _ClassInstanceState();
}

class _ClassInstanceState extends State<ClassInstance> {
  String _errorMessage = "";
  bool _loading = false;

  void submit() {
    var data = {
      "student_id": widget.stdId,
      "qr_code": widget.qrData,
    };
    var url = "student_register_new_class.php";
    setState(() {
      _errorMessage = "";
      _loading = true;
    });
    // call the postScan method and handle the result
    postScan(data, url, (result, error) {
      if (result == null) {
        setState(() {
          _loading = false;
          _errorMessage = error ?? "Unknown error occurred.";
        });
      } else {
        setState(() {
          _loading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StudentHomeScreen()),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register this class",
          style: TextStyle(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),
        ),
        backgroundColor: const Color(0xff008346),
      ),
      body: Container(
          width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(children: [
           Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            child: Card(
              
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow:  [
                      BoxShadow(
                         color: Colors.grey.shade200,
                         spreadRadius: 0.5,
                         blurRadius: 3,
                          // offset: Offset(0, 3)
                          )
                    ]),
                child:Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      
                        children: [
                          const Expanded(child: Text("Lecturer")),

                          Expanded(child: Text(widget.model.lec_name,style:
                           const TextStyle( fontSize: 14,
                           fontWeight: FontWeight.bold,

                           ),))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(child: Text("Unit")),
                          Expanded(child: Text(widget.model.unit_name,style: const TextStyle( fontSize: 14,
                           fontWeight: FontWeight.bold,
                           
                           ),))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(child: Text("Unit Code")),
                          Expanded(child: Text(widget.model.unit_code,style: const TextStyle( fontSize: 14,
                           fontWeight: FontWeight.bold,
                           
                           ),))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(child: Text("Semester")),
                          Expanded(child: Text(widget.model.class_sem,style: const TextStyle( fontSize: 14,
                           fontWeight: FontWeight.bold,
                           
                           ),))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(child: Text("Year")),
                          Expanded(child: Text(widget.model.class_year,style: const TextStyle( fontSize: 14,
                           fontWeight: FontWeight.bold,
                           
                           ),))
                        ],
                        
                      ),
                       const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Expanded(child: ElevatedButton(onPressed: () {
                            
                          },child: const Text("Register"),style: ElevatedButton.styleFrom(
  
                      backgroundColor: Colors.green, 
                      elevation: 5, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                    ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // button padding
                ),
              )),
              const Spacer(),
                          Expanded(child: ElevatedButton(onPressed: () {
                                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StudentHomeScreen()),
                    );
                            
                          },child: const Text("Cancel"),style: ElevatedButton.styleFrom(
  
                      backgroundColor: Colors.red, 
                      elevation: 5, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                    ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // button padding
                ),))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}