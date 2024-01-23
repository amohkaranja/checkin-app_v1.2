import 'package:checkin/components/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: const Image(
                            image: AssetImage("assets/images/chalk_board.png"),
                            height: 60,
                          ),
                       ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                             width: MediaQuery.of(context).size.width * 0.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              UI.text("SCO 100",fontWeight: FontWeight.w800),
                               Spacer(),
                              UI.text("2024-01-10",fontStyle: FontStyle.italic,fontWeight: FontWeight.w300),
                            ],),
                          ),
                          UI.text("Computer Fundermental"),
                          UI.text("James Doe"),
                        ],
                      )],
                  ),
                ),
              )
    );
  }
}