import 'package:checkin/components/base_ui.dart';
import 'package:checkin/themes/app_theme.dart';
import 'package:flutter/material.dart';

enum ButtonSizeType {
  large(1),
  medium(2),
  small(3),
  mini(4);

  final num value;
  const ButtonSizeType(this.value);
}

class ButtonUI extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool block;
  final bool isActive;
  final ButtonStyle? style;
  final bool isNegative;
  const ButtonUI(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.block,
      required this.style,
      this.isNegative = false,
      this.isActive = false});

  @override
  Widget build(BuildContext context) {
    Size? getSize(Set<MaterialState> states) {
      if (block) {
        return const Size.fromHeight(50);
      }
      return null;
    }

    Color? getColor(Set<MaterialState> states) {
      if (isNegative) {
        return AppTheme.lavenderPurple;
      } else if (!isActive) {
        return AppTheme.deactivatedText;
      } else {
        return null;
      }
    }

    return ElevatedButton(
      style: style?.copyWith(
        minimumSize: MaterialStateProperty.resolveWith(getSize),
        backgroundColor: MaterialStateProperty.resolveWith(getColor),
      ),
      onPressed: () {
        isActive ? onPressed.call() : null;
      },
      child: Text(text.toUpperCase()),
    );
  }
}

class ButtonLargeCircularUI extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  final IconData icon;
  final ButtonSizeType sizeType;
  final Color? bgColor;
  final Color? iconColor;

  ButtonLargeCircularUI(
      {super.key,
      this.text,
      this.onPressed,
      required this.icon,
      this.sizeType = ButtonSizeType.large,
      this.bgColor,
      this.iconColor});

  final List<double> radiusVals = [50, 37, 25, 20];
  final List<double> sizeVals = [70, 40, 30, 20];

  @override
  Widget build(BuildContext context) {
    double radius = radiusVals[sizeType.index];
    double iconSize = sizeVals[sizeType.index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            onPressed?.call();
          },
          child: CircleAvatar(
            backgroundColor: bgColor ?? AppTheme.primaryColor,
            radius: radius,
            child: Icon(
              icon,
              size: iconSize,
              color: iconColor ?? AppTheme.bgColor,
            ),
          ),
        ),
        if (text != null) ...[const SizedBox(height: 5), UI.text(text ?? "")]
      ],
    );
  }
}
