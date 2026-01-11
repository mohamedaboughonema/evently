import 'package:evently/custom_widgets/special_text_field.dart';
import 'package:evently/provider/events_list_provider.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/ui/home_screen/tabs/home_tab/event_widget.dart';
import 'package:evently/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var eventsListProvider = Provider.of<EventsListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    if (eventsListProvider.favouriteEventsList.isEmpty) {
      eventsListProvider.getFavouriteEvents(
          userProvider.currentUser!.id ?? 'nullable which is impossible');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SpecialTextField(
            prefixIcon: Icon(Icons.search),
            labelText: AppLocalizations.of(context)!.search_event,
            borderColor: AppColor.primaryBlue,
            iconColor: AppColor.primaryBlue,
            textColor: AppColor.primaryBlue,
          ),
          eventsListProvider.favouriteEventsList.isEmpty
              ? Center(
                  child: Text('No Favourite Events'),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: eventsListProvider.favouriteEventsList.length,
                    itemBuilder: (context, index) {
                      return EventWidget(
                        event: eventsListProvider.favouriteEventsList[index],
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}
