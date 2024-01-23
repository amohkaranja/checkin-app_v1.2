import 'dart:convert';

import 'package:checkin/components/base_ui.dart';
import 'package:checkin/components/ui/skeleton_ui.dart';
import 'package:checkin/models/user_model.dart';
import 'package:checkin/themes/app_theme.dart';
import 'package:checkin/utils/apis_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ScannedClasses extends StatefulWidget {
  const ScannedClasses({super.key});

  @override
  State<ScannedClasses> createState() => _ScannedClassesState();
}

class _ScannedClassesState extends State<ScannedClasses> {
  String errorMessage = "";
  bool loading = true;
  late List<ScannedClass> scannedClasses = [];

  void loadScannedClasess() async {
    final prefs = await SharedPreferences.getInstance();
    var id = (prefs.getString("student_id"));
    var data = {"student_id": id};
    var url = Uri.parse("${api}load_history_scanned.php");
    var response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);

      List<ScannedClass> scannedClassesList = parseResponseData(responseData);

      setState(() {
        if (scannedClassesList.isEmpty) {
          errorMessage = "You have no registered classes";
        }
        scannedClasses = scannedClassesList.cast<ScannedClass>();
      });
      loading = false;
    } else {
      errorMessage = "Error fetching scanned classes, try again later";
      loading = false;
    }
  }

  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      loadScannedClasess();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.primaryColor,
        toolbarHeight: 50,
        title: UI.textHS(
          "Scanned classes",
          textColor: Colors.white,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
        child: loading
            ? Skeleton()
            : scannedClasses.isEmpty
                ? Center(
                    child: UI.text(errorMessage),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: const Image(
                                  image: AssetImage(
                                      "assets/images/blue_qr_code.png"),
                                  height: 60,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        UI.text(
                                            scannedClasses[index].class_date,
                                            fontWeight: FontWeight.w800),
                                        Spacer(),
                                        UI.text(
                                            scannedClasses[index].class_time,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w300),
                                      ],
                                    ),
                                  ),
                                  UI.text(scannedClasses[index].unit_code),
                                  UI.text(scannedClasses[index].lec_name),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: scannedClasses.length),
      ),
    );
  }
}
