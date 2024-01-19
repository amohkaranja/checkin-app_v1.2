import 'package:checkin/screens/login_page.dart';
import 'package:checkin/screens/student_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    callMain();
  }

  void callMain() async {
    final prefs = await SharedPreferences.getInstance();
    var reg = await prefs.getString('regNo');
    _loading = false;
    if (reg != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StudentHomeScreen()),
      );
    }
  }

  void fetchData() async {
    setState(() {
      _loading = true;
      callMain();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            bottom: 15,
            right: 0,
            child: Column(children: <Widget>[
              const Image(
                image: AssetImage("assets/images/logo.png"),
                height: 200,
                width: 200,
              ),
              const Text("v 2.0"),
              _loading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).focusColor),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    )
                  : Container()
            ]),
          ),
        ],
      ),
    );
  }
}
