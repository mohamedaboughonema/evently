import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class SpecialElevatedButton extends StatelessWidget {
  final Widget? icon;
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final bool centerText;
  final Function onPressed;
  const SpecialElevatedButton(
      {super.key,
      this.backgroundColor = AppColor.primaryBlue,
      this.borderColor = AppColor.primaryBlue,
      this.textColor = AppColor.white,
      required this.text,
      this.icon,
      required this.onPressed,
      this.centerText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor, width: 1),
              borderRadius: BorderRadius.circular(20),
            )),
        onPressed: () {
          onPressed();
        },
        child: Row(
          mainAxisAlignment:
              centerText ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            icon ?? SizedBox(),
            icon != null ? SizedBox(width: 10) : SizedBox(),
            Text(
              text,
              style: AppTextStyle.regular20White.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
