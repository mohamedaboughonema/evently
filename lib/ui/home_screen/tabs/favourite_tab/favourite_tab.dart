import 'package:evently/custom_widgets/special_text_field.dart';
import 'package:evently/ui/home_screen/tabs/home_tab/event_widget.dart';
import 'package:evently/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return EventWidget(isFavourite: true);
                }),
          )
        ],
      ),
    );
  }
}
