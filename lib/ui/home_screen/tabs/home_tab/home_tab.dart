import 'package:evently/provider/events_list_provider.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/ui/home_screen/tabs/home_tab/event_widget.dart';
import 'package:evently/ui/home_screen/tabs/home_tab/tab_widget.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var eventsListProvider = Provider.of<EventsListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    if (eventsListProvider.eventsList.isEmpty) {
      // print("build called");
      eventsListProvider.getAllEvents(
          userProvider.currentUser!.id ?? 'nullable which is impossible');
    }
    eventsListProvider.getCategoriesList(context);
    // List<String> categories = [
    //   AppLocalizations.of(context)!.all,
    //   AppLocalizations.of(context)!.birthday,
    //   AppLocalizations.of(context)!.sport,
    //   AppLocalizations.of(context)!.meeting,
    //   AppLocalizations.of(context)!.gaming,
    //   AppLocalizations.of(context)!.eating,
    //   AppLocalizations.of(context)!.holiday,
    //   AppLocalizations.of(context)!.exhibition,
    //   AppLocalizations.of(context)!.workshop,
    //   AppLocalizations.of(context)!.book_club,
    // ];
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                        userProvider.currentUser!.name ??
                            'Nullable User which is impossible',
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
                length: eventsListProvider.categories.length,
                child: TabBar(
                  onTap: (value) {
                    eventsListProvider.changeSelectedIndex(
                        value,
                        userProvider.currentUser!.id ??
                            'nullable which is impossible');
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
                  tabs: eventsListProvider.categories.map((categoryName) {
                    return TabWidget(
                        selectedBackgroundColor:
                            Theme.of(context).indicatorColor,
                        unSelectedBackgroundColor: AppColor.transparent,
                        borderColor: Theme.of(context).indicatorColor,
                        isSelected: eventsListProvider.selectedIndex ==
                            eventsListProvider.categories.indexOf(categoryName),
                        tabTitle: categoryName);
                  }).toList(),
                ),
              )
            ],
          ),
        ),
        body: eventsListProvider.filteredList.isEmpty
            ? Center(
                child: Text('No Events'),
              )
            : ListView.builder(
                itemCount: eventsListProvider.filteredList.length,
                itemBuilder: (context, index) {
                  return EventWidget(
                    event: eventsListProvider.filteredList[index],
                  );
                },
              ));
  }
}
