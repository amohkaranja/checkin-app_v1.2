import 'package:checkin/components/base_ui.dart';
import 'package:checkin/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WaitDialog {
    final BuildContext context;
  final String? message;
  const WaitDialog(
    this.context, {
    this.message,
  });

    void show() {
    showDialog(
      context: context,
      builder: (context) =>
         dotsWaitWidget(),
    );
  }
    void hide() {
    Navigator.of(context).pop();
  }

    Widget dotsWaitWidget() {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      backgroundColor: AppTheme.bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           SizedBox(
            height: 200,
            width: 200,
            child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppTheme.primaryColor,
                  size: 50,
                ) ,
          ),
          if (message != null) ...{
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: UI.text(
                message ?? "",
                fontSize: 16,
              ),
            ),
          },
        ],
      ),
    );
  }
}