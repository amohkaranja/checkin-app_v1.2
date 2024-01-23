import 'package:checkin/models/user_model.dart';
import 'package:checkin/themes/app_theme.dart';
import 'package:checkin/utils/apis_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ScanClass extends StatefulWidget {
  final String otp;
  const ScanClass({super.key, required this.otp});

  @override
  State<ScanClass> createState() => _ScanClassState();
}

class _ScanClassState extends State<ScanClass> {
  Profile? _profile;
  String error_message = "";
  late ClassModel myclass;
  bool _isLoading = true;
  void checkInClass() async {
    var data = {"student_id": _profile!.id, "qr_code": widget.otp};
    var url = "student_class_scan.php";
    setState(() {
      error_message = "";
      _isLoading = true;
    });
   var apiUrl = Uri.parse(api + url);
  var response = await http.post(apiUrl, body: data);

  var jsonResponse =
      await convert.jsonDecode(response.body) as Map<String, dynamic>;
  switch (jsonResponse["success"]) {
    case '1':
      callback("success", null);
      break;
    case '2':
      callback("2", {
        "model": ClassModel.fromJson(jsonResponse["scans"][0]),
        "stdId": data["student_id"],
        "qrData": data["qr_code"]
      });
      break;
    case '3':
      error_message= "Already Signed in!";
      break;
    case '4':
      error_message="Failed to sign in!. Please try again";
      break;
    case '5':
      error_message= "Failed to register!. Please try again";
      break;
  }
  }

  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      checkInClass();
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
            child: Column(
          children: [],
        )),
      ),
    );
  }
}
