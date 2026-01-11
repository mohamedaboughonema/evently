import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomAlertDialoge {
  static void showLoading(
      {required BuildContext context, required String message}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Row(
            children: [
              CircularProgressIndicator(),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    message,
                    style: AppTextStyle.medium16Black,
                  )),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.of(context).pop();
  }

  static void showMessage(
      {required BuildContext context,
      required String message,
      String? title,
      String? posActionname,
      Function? posAction,
      String? negActionname,
      Function? negAction}) {
    List<Widget> actions = [];
    if (posActionname != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            posAction?.call();
          },
          child: Text(
            posActionname,
            style: AppTextStyle.medium16Black,
          ),
        ),
      );
    }
    if (negActionname != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            negAction?.call();
          },
          child: Text(
            negActionname,
            style: AppTextStyle.medium16Black,
          ),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(
              title ?? '',
              style: AppTextStyle.medium16Black,
            ),
            content: Text(
              message,
              style: AppTextStyle.medium16Black,
            ),
            actions: actions);
      },
    );
  }
}
