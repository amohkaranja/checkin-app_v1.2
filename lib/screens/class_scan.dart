import 'package:checkin2/screens/class_instance.dart';
import 'package:checkin2/screens/student_home.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../models/user_model.dart';
import '../utils/apis_list.dart';

class ClassScan extends StatefulWidget {
  const ClassScan({super.key});

  @override
  State<ClassScan> createState() => _ClassScanState();
}

class _ClassScanState extends State<ClassScan> {
    Profile? _profile; 
    bool isScanCompleted=false;
  bool isFlashon= false;
  bool isFrontCamera=false;
  String _errorMessage = "";
  bool _loading=false;
  MobileScannerController scannerController= MobileScannerController();
  void closeScreen(){
    isScanCompleted=false;
  }
  submit(Code){
    print("step 7");
    var data={"student_id":_profile!.id,"qr_code":Code};
    var url="qr_code";
    print("step 8");
      setState(() {
      _errorMessage = "";
      _loading=true;
    });
postScan(data, url, (result, error) => {
              if (result == null)
                {
                  setState(() {
                  _loading=false;
                }),
                  setState(() {
                    _errorMessage = error;
                  })
                }
                else if(result=="2"){
              ClassInstance(model:error["model"],stdId:error["stdId"],qrData:error["qrData"],)
                }
              else
                {
                    setState(() {
                  _loading=false;
                }),
               
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentHomeScreen()),
                  )
                }
            });
  }
   
     @override
void initState() {
  super.initState();
  loadProfileData();
  }
    Future<void> loadProfileData() async {
  final profile = await profileData();
   setState(() {
      _profile = profile; // assign the value of profile to _profile
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
          IconButton(onPressed: (){
            setState(() {
              isFlashon=!isFlashon;
             scannerController.toggleTorch();
            });
          }, icon: Icon(Icons.flash_on,color:isFlashon?Colors.blue: Colors.white,)),
          IconButton(onPressed: (){
        setState(() {
              isFrontCamera=!isFrontCamera;
             scannerController.switchCamera();
            });

          }, icon: Icon(Icons.camera_front,color:isFrontCamera?Colors.blue: Colors.white,))
        ],
         centerTitle: true,
        title: const Text(
          "Scan Class",
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
             Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
           Text("Place the QR code in the area",
           style: TextStyle(
             color: Colors.black87,
             fontSize: 18,
             fontWeight: FontWeight.bold,
             letterSpacing: 1
           ),
           ),
           SizedBox(
             height: 10,
           ),
            Text("Scanning will be started automatically",
           style: TextStyle(
             color: Colors.black54,
             fontSize: 16,
             fontWeight: FontWeight.bold,
             letterSpacing: 1
           ),)
              ],
            )),
             Expanded(flex: 4, child: Container(
            child: MobileScanner(
              controller: scannerController,
        onDetect: (capture){
          print("step 1");
              final List<Barcode> barcodes = capture.barcodes;
              print("step 2");
             String code;
               for (final barcode in barcodes) {
                print("step 3");
                if(!isScanCompleted){
                  print("step 4");
                  code=barcode.rawValue??'---';
                  print("step 5");
                  isScanCompleted=true;
                  print("step 6");
                  submit( code);
                }
          }
            }),
          )),
           Expanded(child: Container(
            alignment: Alignment.center,
            child:  const Text("powered by Javan informatics",
           style: TextStyle(
             color: Colors.black54,
             fontSize: 14,
             fontWeight: FontWeight.bold,
             letterSpacing: 1
           ),),
          ))
        ]),
      ),
    );
  }
}