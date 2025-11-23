import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class SpecialTextButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const SpecialTextButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onPressed();
        },
        child: RichText(
            text: TextSpan(
                text: text,
                style: AppTextStyle.medium16Primary.copyWith(
                  decoration: TextDecoration.underline,
                ))));
  }
}
