import 'dart:convert';

import 'package:checkin/components/base_ui.dart';
import 'package:checkin/components/ui/skeleton_ui.dart';
import 'package:checkin/models/user_model.dart';
import 'package:checkin/screens/student_home1.dart';
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
  bool loading = true;

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
      setState(() {
        if (registeredClassesList.isEmpty) {
          errorMessage = "You have no registered classes";
        }
        classes = registeredClassesList;
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
      loadClasses();
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
          "My classes",
          textColor: Colors.white,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
        child: loading
            ? Skeleton()
            : classes.isEmpty
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
                                      "assets/images/chalk_board.png"),
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
                                        UI.text(classes[index].unit_code,
                                            fontWeight: FontWeight.w800),
                                        Spacer(),
                                        UI.text(classes[index].date_reg,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w300),
                                      ],
                                    ),
                                  ),
                                  UI.text(classes[index].unit_name),
                                  UI.text(classes[index].lec_name),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: classes.length),
      ),
    );
  }
}
