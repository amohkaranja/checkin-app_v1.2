import 'package:checkin/screens/student_home.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../models/user_model.dart';
import '../utils/apis_list.dart';
import 'class_instance.dart';

class ClassScanII extends StatefulWidget {
  const ClassScanII({super.key});

  @override
  State<ClassScanII> createState() => _ClassScanIIState();
}

class _ClassScanIIState extends State<ClassScanII> {
   Profile? _profile; 
  Barcode? result;
  QRViewController?controller;
   String _errorMessage = "";
  bool _loading=false;
   bool isFlashon= false;
  bool isFrontCamera=false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'Qr');
 submit(Code){
    var data={"student_id":_profile!.id,"qr_code":Code};
    var url="student_class_scan.php";
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
                
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ClassInstance(model:error["model"],stdId:error["stdId"],qrData:error["qrData"],)),
                  )
              
                }
              else
                {
                    setState(() {
                  _loading=false;
                }),
               
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StudentHomeScreen()),
                  )
                }
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
             controller?.toggleFlash();
            });
          }, icon: Icon(Icons.flash_on,color:isFlashon?Colors.blue: Colors.white,)),
            IconButton(onPressed: (){
        setState(() {
              isFrontCamera=!isFrontCamera;
             controller?.flipCamera();
            });

          }, icon: Icon(Icons.camera_front,color:isFrontCamera?Colors.blue: Colors.white,))
        ],
         centerTitle: true,
        title: const Text(
          "Scan Class",
          style: TextStyle(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Theme.of(context).focusColor,
      ),
      body: Container(
          width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
               Expanded(
                flex: 1,
                 child: Container(
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
                             color: Theme.of(context).primaryColor,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3))
                      ]),
                  child: const Image(
                    height:120,
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.contain,
                  ),
                             ),
                           ),
                         ),
               ),
                 Expanded(
                  flex: 1,
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                  _errorMessage != ""
                  ? Container(
                      height: 20,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        "$_errorMessage",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : Container(height: 1),
           const Text("Place the QR code in the area",
           style: TextStyle(
             fontSize: 12,
             fontWeight: FontWeight.bold,
             letterSpacing: 1
           ),
           ),
           const SizedBox(
             height: 10,
           ),
            const Text("Scanning will be started automatically",
           style: TextStyle(
             fontSize: 12,
             fontWeight: FontWeight.bold,
             letterSpacing: 1
           ),)
              ],
            )),
          Expanded(
            flex: 4,
            child: _buildQrView(context)),
             Expanded(
              flex: 1,
              child: Container(
            alignment: Alignment.center,
            child:  const Text("powered by Javan informatics",
           style: TextStyle(
             fontSize: 14,
             fontWeight: FontWeight.bold,
             letterSpacing: 1
           ),),
          ))
          ],
        ),
      ),
    );
  }
  Widget _buildQrView(BuildContext context){
var scanArea =(MediaQuery.of(context).size.width<400||MediaQuery.of(context).size.height<400)?150:300;

  return QRView(key: qrKey, onQRViewCreated: _onQRViewCreated,overlay: QrScannerOverlayShape(
    borderColor: Colors.red,
    borderRadius: 10,
    borderLength: 30,
    borderWidth: 10,
    cutOutSize: scanArea.toDouble()),);
}

void _onQRViewCreated(QRViewController controller){
    setState(() {
      this.controller=controller;
    });
    controller.scannedDataStream.listen((scanData) {
      submit(scanData);
     });
}
}
