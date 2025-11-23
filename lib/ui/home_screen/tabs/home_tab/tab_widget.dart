import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  final Color borderColor;
  final Color selectedBackgroundColor;
  final Color unSelectedBackgroundColor;
  final String tabTitle;
  final bool isSelected;
  const TabWidget(
      {super.key,
      required this.isSelected,
      required this.tabTitle,
      required this.borderColor,
      required this.selectedBackgroundColor,
      required this.unSelectedBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? selectedBackgroundColor : unSelectedBackgroundColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Text(
        tabTitle,
      ),
    );
  }
}
