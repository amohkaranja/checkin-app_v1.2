import 'package:flutter/material.dart';

class InputAction extends StatelessWidget {
  final IconData icon;
  final Function() callback;
  const InputAction({
    super.key,
    required this.icon,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: callback,
      icon: Icon(
        icon,
        color: Colors.grey,
      ),
    );
  }
}
