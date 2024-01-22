import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:checkin/components/base_ui.dart';
import 'package:checkin/components/ui/buttons_ui.dart';
import 'package:checkin/screens/class_scan.dart';
import 'package:checkin/screens/generate_code.dart';
import 'package:checkin/screens/login_page.dart';
import 'package:checkin/screens/registered_classes1.dart';
import 'package:checkin/screens/student_home.dart';
import 'package:checkin/screens/user_profile.dart';
import 'package:checkin/themes/app_theme.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int _currentIndex = 0;
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  void onNavigate(BuildContext context, int type) {
    Widget page = const HomeScreen();
    if (type == 1) {
      page = const ClassScanII();
    } else if (type == 2) {
      page = const GenerateCode();
    } else if (type == 3) {
      page = const StudentHomeScreen();
    } else if (type == 4) {
      page = const User_Profile();
    } else if (type == 5) {
      page = const RegisteredClasses();
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          toolbarHeight: 10,
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      UI.cardView(
                        label: "",
                        onPressed: () {},
                        child: CircularSeekBar(
                          width: double.infinity,
                          height: 150,
                          progress: 100,
                          barWidth: 8,
                          startAngle: 45,
                          sweepAngle: 270,
                          strokeCap: StrokeCap.butt,
                          progressGradientColors: const [
                            Colors.red,
                            Colors.orange,
                            Colors.yellow,
                            Colors.green,
                            Colors.blue,
                            Colors.indigo,
                            Colors.purple
                          ],
                          innerThumbRadius: 5,
                          innerThumbStrokeWidth: 3,
                          innerThumbColor: Colors.white,
                          outerThumbRadius: 5,
                          outerThumbStrokeWidth: 10,
                          outerThumbColor: Colors.blueAccent,
                          dashWidth: 1,
                          dashGap: 2,
                          animation: true,
                          curves: Curves.bounceOut,
                          valueNotifier: _valueNotifier,
                          child: Center(
                            child: ValueListenableBuilder(
                                valueListenable: _valueNotifier,
                                builder: (_, double value, __) => Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        UI.text(
                                          '${value.round()}',
                                        ),
                                        UI.text(
                                          'My Attendance %',
                                        ),
                                      ],
                                    )),
                          ),
                        ),
                      ),
                      UI.cardView(
                        label: "Scan Class",
                        onPressed: () {
                          onNavigate(context, 1);
                        },
                        child: Image(
                          image: AssetImage("assets/images/qr_code_black.png"),
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: UI.cardView(
                              isBlock: false,
                              label: "Registered class",
                              onPressed: () {
                                onNavigate(context, 5);
                              },
                              child: Image(
                                image:
                                    AssetImage("assets/images/chalk_board.png"),
                                height: 80,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: UI.cardView(
                              isBlock: false,
                              label: "Scanned Activities",
                              onPressed: () {},
                              child: Image(
                                image: AssetImage(
                                    "assets/images/time_machine.png"),
                                height: 80,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      UI.cardView(
                        label: "Generate my QR Code",
                        onPressed: () {},
                        child: Image(
                          image: AssetImage("assets/images/blue_qr_code.png"),
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    child: UI.buttonLC(
                        icon: Icons.message,
                        onPressed: () {},
                        sizeType: ButtonSizeType.small),
                    bottom: 60,
                    right: 0,
                  ),
                ],
              ),
            )),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: BottomBarFloating(
            items: items,
            titleStyle: Theme.of(context).textTheme.bodyMedium,
            backgroundColor: AppTheme.primaryColor,
            color: Colors.white,
            colorSelected: Colors.orange,
            indexSelected: _currentIndex,
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
                  MaterialPageRoute(builder: (context) => const User_Profile()),
                );
              }
            }),
          ),
        ));
  }
}

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
