import 'package:checkin/components/base_ui.dart';
import 'package:flutter/material.dart';

class CardDisplay extends StatelessWidget {
  final String? label;
  final bool isBlock;
  final Function onPressed;
  final Widget child;
  const CardDisplay({
    super.key,
    this.label,
    required this.isBlock,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: GestureDetector(
          onTap: () {
            onPressed.call();
          },
          child: Card(
            child: Padding(
              padding: isBlock? EdgeInsets.symmetric(horizontal:20.0, vertical:20):EdgeInsets.symmetric(horizontal:10.0,vertical: 20),
              child: Center(
                child: Column(children: <Widget>[
                  child,
                  if (label != null) ...[UI.text("$label")]
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
