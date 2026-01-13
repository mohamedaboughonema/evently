import 'package:evently/utils/app_color.dart';
import 'package:flutter/material.dart';

class SelectionWidget extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;
  const SelectionWidget(
      {super.key, required this.widget1, required this.widget2});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.primaryBlue, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget1,
          SizedBox(width: 8),
          widget2,
        ],
      ),
    );
  }
}
