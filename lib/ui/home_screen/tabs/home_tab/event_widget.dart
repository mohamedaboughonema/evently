import 'package:evently/model/event.dart';
import 'package:evently/provider/events_list_provider.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventWidget extends StatelessWidget {
  final Event event;
  const EventWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var eventsListProvider = Provider.of<EventsListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(10),
      height: 220,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(event.image!),
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
                  event.date!.day.toString(),
                  style: AppTextStyle.bold20Primary,
                ),
                Text(
                  DateFormat('MMM').format(event.date!),
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
                    event.title!,
                    style: AppTextStyle.bold14Black
                        .copyWith(color: Theme.of(context).primaryColorDark),
                  ),
                  InkWell(
                    onTap: () {
                      eventsListProvider.updateIsFavourite(
                          event,
                          userProvider.currentUser!.id ??
                              'nullable which is impossible');
                    },
                    child: Icon(
                      event.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: AppColor.blue,
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
