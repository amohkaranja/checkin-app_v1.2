import 'dart:convert';

import 'package:checkin/components/base_ui.dart';
import 'package:checkin/models/user_model.dart';
import 'package:checkin/themes/app_theme.dart';
import 'package:checkin/utils/apis_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisteredClasses extends StatefulWidget {
  const RegisteredClasses({super.key});

  @override
  State<RegisteredClasses> createState() => _RegisteredClassesState();
}

class _RegisteredClassesState extends State<RegisteredClasses> {
  late String errorMessage = "";
  late List<RegisteredClass> classes = [];

  void loadClasses() async {
    final prefs = await SharedPreferences.getInstance();
    var id = (prefs.getString("student_id"));
    var data = {"student_id": id};
    var url = Uri.parse("${api}load_registered_classes.php");
    var response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      List<RegisteredClass> registeredClassesList =
          parseResponseJsonData(responseData);
      classes = registeredClassesList;
    } else {
      print("Error fetching scanned classes, try again later");
    }
  }

  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      loadClasses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        toolbarHeight: 50,
        title: UI.textHS("My classes", textColor: Colors.black),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
            child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [UI.text(classes[index].lec_name)],
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: classes.length)),
      ),
    );
  }
}
