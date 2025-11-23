import 'package:evently/ui/home_screen/tabs/home_tab/event_widget.dart';
import 'package:evently/ui/home_screen/tabs/home_tab/tab_widget.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.eating,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
    ];
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: 160,
          title: Column(
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcome_back,
                        style: AppTextStyle.regular14White,
                      ),
                      Text(
                        'Mohamed Omar',
                        style: AppTextStyle.bold24White,
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.sunny, color: AppColor.white, size: 28),
                  SizedBox(width: 12),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'EN',
                      style: AppTextStyle.bold14Primary,
                    ),
                  )
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white, size: 16),
                  Text(
                    'Alexandria, Egypt',
                    style: AppTextStyle.medium14White,
                  ),
                ],
              ),
              SizedBox(height: 12),
              DefaultTabController(
                length: categories.length,
                child: TabBar(
                  onTap: (value) {
                    selectedIndex = value;
                    setState(() {});
                  },
                  padding: EdgeInsets.all(0),
                  labelPadding: EdgeInsets.all(5),
                  tabAlignment: TabAlignment.start,
                  labelStyle: AppTextStyle.bold14Primary
                      .copyWith(color: Theme.of(context).secondaryHeaderColor),
                  unselectedLabelStyle: AppTextStyle.medium14White,
                  indicatorColor: AppColor.transparent,
                  dividerColor: AppColor.transparent,
                  isScrollable: true,
                  tabs: categories.map((categoryName) {
                    return TabWidget(
                        selectedBackgroundColor:
                            Theme.of(context).indicatorColor,
                        unSelectedBackgroundColor: AppColor.transparent,
                        borderColor: Theme.of(context).indicatorColor,
                        isSelected:
                            selectedIndex == categories.indexOf(categoryName),
                        tabTitle: categoryName);
                  }).toList(),
                ),
              )
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return EventWidget(
              isFavourite: false,
            );
          },
        ));
  }
}
