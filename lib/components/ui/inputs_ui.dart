import 'package:checkin/app/app_config.dart';
import 'package:checkin/components/base_ui.dart';
import 'package:checkin/components/ui/input_action.dart';
import 'package:checkin/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/services.dart';

class InputUI extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextAlign? textAlign;
  final TextStyle? textFormat;
  final Function(String?)? onChange;
  final Function(String?)? onSubmitted;
  final Function? onFocus;
  final int? charLimit;
  final bool focused;
  final bool isPassword;
  final String passwordChar;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final bool multiLines;
  final TextCapitalization textCapitalization;
  const InputUI({
    super.key,
    this.hint = "",
    this.controller,
    this.inputType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.textFormat,
    this.onChange,
    this.onSubmitted,
    this.onFocus,
    this.charLimit,
    this.focused = false,
    this.isPassword = false,
    this.passwordChar = '•',
    this.focusNode,
    this.nextNode,
    this.multiLines = false,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  State<StatefulWidget> createState() => _InputUIState();
}

class _InputUIState extends State<InputUI> {
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? getTextStyle() {
      return widget.textFormat == null
          ? null
          : Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: widget.textFormat?.fontSize,
                fontWeight: widget.textFormat?.fontWeight,
              );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: isFocused ? AppTheme.primaryColor : AppTheme.inputBorder,
          width: 1,
        ),
      ),
      child: Focus(
        child: TextField(
          style: getTextStyle(),
          obscureText: widget.isPassword,
          obscuringCharacter: widget.passwordChar,
          autofocus: widget.focused,
          inputFormatters: [
            if (widget.charLimit != null) ...[
              LengthLimitingTextInputFormatter(widget.charLimit)
            ]
          ],
          onChanged: (value) {
            widget.onChange?.call(value);
          },
          onSubmitted: (value) {
            widget.onSubmitted?.call(value);
          },
          textAlign: widget.textAlign ?? TextAlign.start,
          focusNode: widget.focusNode,
          controller: widget.controller,
          keyboardType:
              widget.multiLines ? TextInputType.multiline : widget.inputType,
          maxLines: widget.multiLines ? 4 : 1,
          decoration: InputDecoration.collapsed(
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: AppTheme.hintTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        onFocusChange: (hasFocus) {
          setState(() {
            isFocused = hasFocus;
          });
          if (hasFocus) {
            widget.onFocus?.call();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class FormInputUI extends StatefulWidget {
  final String? hint;
  final String? label;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextAlign? textAlign;
  final TextStyle? textFormat;
  final Function(String?)? onChange;
  final Function(String?)? onSubmitted;
  final Function()? onComplete;
  final int? charLimit;
  final bool focused;
  final bool isPassword;
  final String passwordChar;
  final FocusNode? focusNode;
  final bool multiLines;
  final TextCapitalization? textCapitalization;
  final bool isOptional;
  final int? maxLength;
  final AutovalidateMode? autovalidate;
  final String? errorText;
  final String? Function(String?)? validator;
  final InputAction? inputAction;

  const FormInputUI({
    super.key,
    this.hint,
    this.label,
    this.controller,
    this.inputType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.textFormat,
    this.onChange,
    this.onSubmitted,
    this.onComplete,
    this.charLimit,
    this.focused = false,
    this.isPassword = false,
    this.passwordChar = '•',
    this.focusNode,
    this.multiLines = false,
    this.textCapitalization,
    this.isOptional = false,
    this.autovalidate,
    this.errorText,
    this.validator,
    this.inputAction,
    this.maxLength,
  });

  @override
  State<FormInputUI> createState() => _FormInputUIState();
}

class _FormInputUIState extends State<FormInputUI> {
  bool isFocused = false;

  TextStyle? getTextStyle() {
    return widget.textFormat == null
        ? null
        : Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: widget.textFormat?.fontSize,
              fontWeight: widget.textFormat?.fontWeight,
            );
  }

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(() {
      setState(() {
        isFocused = widget.focusNode!.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        if(widget.label!="")...[UI.text("${widget.label!}")],
         Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 12,
            ),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: isFocused ? AppTheme.primaryColor : AppTheme.inputBorder,
                width: 1,
              ),
            ),
            child: Focus(
              child: TextFormField(
                style: getTextStyle(),
                controller: widget.controller,
                obscureText: widget.isPassword,
                obscuringCharacter: widget.passwordChar,
                autofocus: widget.focused,
                textAlign: widget.textAlign ?? TextAlign.start,
                focusNode: widget.focusNode,
                autovalidateMode: widget.autovalidate,
                textCapitalization:
                    widget.textCapitalization ?? TextCapitalization.sentences,
                inputFormatters: [
                  if (widget.charLimit != null) ...[
                    LengthLimitingTextInputFormatter(widget.charLimit)
                  ]
                ],
                keyboardType: widget.multiLines
                    ? TextInputType.multiline
                    : widget.inputType,
                maxLines: widget.multiLines ? 4 : 1,
                decoration: InputDecoration.collapsed(
                  hintText: widget.hint,
                  hintStyle: const TextStyle(
                    color: AppTheme.hintTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onChanged: (value) {
                  widget.onChange?.call(value);
                },
                onFieldSubmitted: (value) {
                  widget.onSubmitted?.call(value);
                },
                validator: widget.isOptional
                    ? (value) {
                        return null;
                      }
                    : widget.validator ??
                        (value) {
                          if (value == null || value.isEmpty) {
                            return widget.errorText ?? "Input is required";
                          }
                          return null;
                        },
                onEditingComplete: widget.onComplete,
              ),
              onFocusChange: (hasFocus) {
                setState(
                  () {
                    isFocused = hasFocus;
                  },
                );
              },
            ),
          ),
          if (widget.inputAction != null) ...{
            Positioned(
              right: 0,
              child: widget.inputAction!,
            )
          },
        ],
      ),]
    );
  }
}

class PhoneInputUI extends StatefulWidget {
  final String? hint;
  final String? label;
  final String? errorText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onInputChanged;
  const PhoneInputUI({
    super.key,
    this.hint,
    this.label,
    this.errorText,
    this.controller,
    this.validator,
    this.onInputChanged,
  });

  @override
  State<PhoneInputUI> createState() => _PhoneInputUIState();
}

class _PhoneInputUIState extends State<PhoneInputUI> {
  PhoneNumber initialPhoneNumber = PhoneNumber(
    isoCode: AppConfig.countryCode,
  );
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UI.text("Phone no"),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 2,
          ),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: isFocused ? AppTheme.primaryColor : AppTheme.inputBorder,
              width: 1,
            ),
          ),
          child: Focus(
            child: InternationalPhoneNumberInput(
              initialValue: initialPhoneNumber,
              hintText: widget.hint,
              textFieldController: widget.controller,
              errorMessage: widget.errorText,
              spaceBetweenSelectorAndTextField: 0,
              onInputChanged: (PhoneNumber number) {
                widget.onInputChanged?.call(number.phoneNumber ?? "");
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                showFlags: true,
              ),
              autoValidateMode: AutovalidateMode.onUserInteraction,
              inputDecoration: InputDecoration.collapsed(
                hintText: widget.hint,
                hintStyle: const TextStyle(
                  color: AppTheme.hintTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onFocusChange: (hasFocus) {
              setState(
                () {
                  isFocused = hasFocus;
                },
              );
            },
          ),
        ),
      ],
    );
  }
}