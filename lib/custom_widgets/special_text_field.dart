import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class SpecialTextField extends StatelessWidget {
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  const SpecialTextField(
      {super.key,
      this.borderColor = AppColor.grey,
      this.hintText,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.iconColor = AppColor.grey,
      this.textColor = AppColor.grey,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          prefixIconColor: iconColor,
          suffixIcon: suffixIcon,
          suffixIconColor: iconColor,
          hintText: hintText,
          hintStyle: AppTextStyle.medium14White.copyWith(color: textColor),
          labelText: labelText,
          labelStyle: AppTextStyle.bold14Primary.copyWith(color: textColor),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: borderColor, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: borderColor, width: 1)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColor.red, width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColor.red, width: 1)),
        ),
      ),
    );
  }
}
