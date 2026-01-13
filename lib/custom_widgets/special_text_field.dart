import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';

typedef Validator = String? Function(String?)?;

class SpecialTextField extends StatelessWidget {
  final Color borderColor;
  final Color iconColor;
  final Color? textColor;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool obscureText;
  final Validator validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  const SpecialTextField(
      {super.key,
      this.borderColor = AppColor.grey,
      this.hintText,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.iconColor = AppColor.grey,
      this.textColor,
      this.maxLines,
      this.obscureText = false,
      this.validator,
      this.controller,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        obscureText: obscureText,
        obscuringCharacter: '*',
        style: AppTextStyle.medium14White
            .copyWith(color: textColor ?? Theme.of(context).hintColor),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          prefixIconColor: iconColor,
          suffixIcon: suffixIcon,
          suffixIconColor: iconColor,
          hintText: hintText,
          hintStyle: AppTextStyle.medium14White
              .copyWith(color: textColor ?? Theme.of(context).hintColor),
          labelText: labelText,
          labelStyle: AppTextStyle.bold14Primary
              .copyWith(color: textColor ?? Theme.of(context).hintColor),
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
