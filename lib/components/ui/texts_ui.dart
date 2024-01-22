import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class TextUI extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Color? textColor;
  final double? fontSize;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final bool isRequired;
  final double bottomMarging;
  const TextUI({
    super.key,
    required this.text,
    this.style = AppTheme.bodyMedium,
    this.textAlign = TextAlign.start,
    this.textColor,
    this.fontWeight,
    this.fontStyle,
    this.fontSize,
    this.isRequired = false,
    this.bottomMarging = 5,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? getStyle() {
      return style?.copyWith(
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontStyle:fontStyle,
      );
    }

    Text normaText = Text(
      text,
      style: getStyle(),
      textAlign: textAlign,
      softWrap: true,
    );
    RichText requiredText = RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: getStyle(),
          ),
          const TextSpan(
            text: '*',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.only(bottom: bottomMarging),
      child: isRequired ? requiredText : normaText,
    );
  }
}

class LinkTextUI extends StatelessWidget {
  final String text;
  final String linkText;
  final TextStyle? style;
  final TextStyle? linkStyle;
  final TextAlign? textAlign;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double bottomMarging;
  final Function()? onLinkTap;
  const LinkTextUI({
    super.key,
    required this.text,
    required this.linkText,
    this.style = AppTheme.bodyMedium,
    this.linkStyle = AppTheme.bodyMedium,
    this.textAlign = TextAlign.start,
    this.textColor,
    this.fontWeight,
    this.fontSize,
    this.bottomMarging = 5,
    this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? getStyle() {
      return style?.copyWith(
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: bottomMarging),
      child: RichText(
        text: TextSpan(
          text: text,
          style: getStyle(),
          children: [
            TextSpan(
              text: linkText,
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  onLinkTap?.call();
                },
            ),
          ],
        ),
      ),
    );
  }
}
