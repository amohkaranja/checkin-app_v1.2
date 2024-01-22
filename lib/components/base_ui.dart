import 'package:checkin/components/ui/buttons_ui.dart';
import 'package:checkin/components/ui/card_ui.dart';
import 'package:checkin/components/ui/input_action.dart';
import 'package:checkin/components/ui/inputs_ui.dart';
import 'package:checkin/components/ui/texts_ui.dart';
import 'package:checkin/components/ui/wait_dialog.dart';
import 'package:checkin/themes/app_theme.dart';
import 'package:flutter/material.dart';

class UI {
  UI._();
  static Widget formInput({
    String? hint,
    String? label = "",
    TextEditingController? controller,
    TextInputType? inputType = TextInputType.text,
    bool isPassword = false,
    String passwordChar = "*",
    bool isOptional = false,
    int? charLimit,
    TextCapitalization? textCapitalization,
    bool multiLines = false,
    AutovalidateMode? autovalidate,
    String? Function(String?)? validator,
    Function(String?)? onChange,
    Function(String?)? onSubmitted,
    Function()? onComplete,
    FocusNode? focusNode,
    InputAction? inputAction,
  }) {
    return FormInputUI(
      hint: hint,
      label: label,
      controller: controller,
      inputType: inputType,
      isPassword: isPassword,
      passwordChar: passwordChar,
      isOptional: isOptional,
      charLimit: charLimit,
      validator: validator,
      onChange: onChange,
      onSubmitted: onSubmitted,
      onComplete: onComplete,
      textCapitalization: textCapitalization,
      multiLines: multiLines,
      autovalidate: autovalidate,
      focusNode: focusNode,
      inputAction: inputAction,
    );
  }

  static Widget phoneInput({
    String? hint,
    String? label,
    String? errorText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Function(String)? onChange,
  }) {
    return PhoneInputUI(
      hint: hint,
      label: label,
      errorText: errorText,
      controller: controller,
      validator: validator,
      onInputChanged: onChange,
    );
  }

  static WaitDialog createWaitDialog(
    BuildContext context, {
    String? message,
  }) {
    return WaitDialog(context, message: message);
  }

  static Widget text(
    String text, {
    TextAlign textAlign = TextAlign.start,
    Color? textColor,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    double? fontSize,
    bool isRequired = false,
    double? bottomMarging,
  }) {
    return TextUI(
      text: text,
      textAlign: textAlign,
      textColor: textColor,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      isRequired: isRequired,
      bottomMarging: bottomMarging ?? 5,
    );
  }

  static Widget linkText(String text, String linkText,
      {TextStyle? linkStyle,
      TextAlign textAlign = TextAlign.start,
      Color? textColor,
      FontWeight? fontWeight,
      double? fontSize,
      bool isRequired = false,
      double? bottomMarging,
      Function()? onLinkTap}) {
    return LinkTextUI(
      text: text,
      linkText: linkText,
      textAlign: textAlign,
      textColor: textColor,
      fontWeight: fontWeight,
      fontSize: fontSize,
      bottomMarging: bottomMarging ?? 5,
      onLinkTap: onLinkTap,
      linkStyle: linkStyle,
    );
  }

  static Widget cardView({
    String? label,
    required final Function onPressed,
     bool isBlock = true,
    required Widget child,
  }) {
    return CardDisplay(
      label: label,
      child: child,
      isBlock: isBlock,
      onPressed: onPressed,
    );
  }

  static Widget buttonLC({
    String? text,
    Function? onPressed,
    required IconData icon,
    ButtonSizeType sizeType = ButtonSizeType.medium,
    Color? bgColor,
    Color? iconColor,
  }) {
    return ButtonLargeCircularUI(
      text: text,
      onPressed: onPressed,
      icon: icon,
      sizeType: sizeType,
      bgColor: bgColor,
      iconColor: iconColor,
    );
  }

  static Widget button({
    required String text,
    required Function onPressed,
    bool isBlock = false,
    ButtonStyle? style,
    bool isNegative = false,
    bool isActive = true,
  }) {
    var btnStyle = style ?? AppTheme.buttonStyle;
    return ButtonUI(
      text: text,
      onPressed: onPressed,
      block: isBlock,
      style: btnStyle,
      isNegative: isNegative,
      isActive: isActive,
    );
  }

  static Widget textHS(String text,
      {TextAlign textAlign = TextAlign.start,
      Color? textColor,
      FontWeight? fontWeight}) {
    return TextUI(
      text: text,
      style: AppTheme.headlineSmall.copyWith(
        color: textColor,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      textColor: textColor,
    );
  }
}
