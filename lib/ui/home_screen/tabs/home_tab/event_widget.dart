import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:evently/utils/asset_manager.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  final bool isFavourite;
  const EventWidget({super.key, required this.isFavourite});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(10),
      height: 220,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsManager.birthdayImage),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.primaryBlue, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  '21',
                  style: AppTextStyle.bold20Primary,
                ),
                Text(
                  'Dec',
                  style: AppTextStyle.bold14Primary,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Description',
                    style: AppTextStyle.bold14Black
                        .copyWith(color: Theme.of(context).primaryColorDark),
                  ),
                  Icon(
                    isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: AppColor.blue,
                  )
                ]),
          )
        ],
      ),
    );
  }
}
