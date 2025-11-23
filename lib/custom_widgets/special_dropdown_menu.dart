import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class SpecialDropDownMenu extends StatelessWidget {
  // final String currentText;
  final String currentCode;
  final String text1;
  final String code1;
  final String text2;
  final String code2;
  final Function onTapListTile;
  const SpecialDropDownMenu(
      {super.key,
      // required this.currentText,
      required this.currentCode,
      required this.text1,
      required this.text2,
      required this.onTapListTile,
      required this.code1,
      required this.code2});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showModalBottomSheet(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      SpecialListTile(
                          listTitle: text1,
                          isSelected: currentCode == code1,
                          onTap: (code) => onTapListTile(code1),
                          code: code1,
                          selectedTitleStyle: AppTextStyle.bold20Primary,
                          unSelectedTitleStyle: AppTextStyle.bold20Black
                              .copyWith(
                                  color: Theme.of(context).primaryColorDark),
                          selectedColor: AppColor.primaryBlue,
                          unSelectedColor: AppColor.transparent),
                      SpecialListTile(
                          listTitle: text2,
                          isSelected: currentCode == code2,
                          onTap: (code) => onTapListTile(code2),
                          selectedTitleStyle: AppTextStyle.bold20Primary,
                          unSelectedTitleStyle: AppTextStyle.bold20Black
                              .copyWith(
                                  color: Theme.of(context).primaryColorDark),
                          selectedColor: AppColor.primaryBlue,
                          unSelectedColor: AppColor.transparent,
                          code: code2)
                    ],
                  ),
                );
              });
        },
        child: DropDownMenuButtonWidget(currentCode == code1 ? text1 : text2));
  }
}

class SpecialListTile extends StatelessWidget {
  final String listTitle;
  final bool isSelected;
  final Function onTap;
  final TextStyle selectedTitleStyle;
  final TextStyle unSelectedTitleStyle;
  final Color selectedColor;
  final Color unSelectedColor;
  final String code;

  const SpecialListTile(
      {super.key,
      required this.listTitle,
      required this.isSelected,
      required this.onTap,
      required this.selectedTitleStyle,
      required this.unSelectedTitleStyle,
      required this.selectedColor,
      required this.unSelectedColor,
      required this.code});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(listTitle,
              style: isSelected ? selectedTitleStyle : unSelectedTitleStyle),
          Icon(Icons.check,
              color: isSelected ? selectedColor : unSelectedColor),
        ],
      ),
      onTap: () {
        onTap(code);
        Navigator.pop(context);
      },
    );
  }
}

class DropDownMenuButtonWidget extends StatelessWidget {
  final String text;
  const DropDownMenuButtonWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primaryBlue),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(text, style: AppTextStyle.bold20Primary),
        Icon(Icons.arrow_drop_down, color: AppColor.primaryBlue, size: 30),
      ]),
    );
  }
}
