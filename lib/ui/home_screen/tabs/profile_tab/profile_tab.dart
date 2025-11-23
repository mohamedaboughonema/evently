import 'package:evently/custom_widgets/special_dropdown_menu.dart';
import 'package:evently/custom_widgets/special_elevated_button.dart';
import 'package:evently/provider/language_provider.dart';
import 'package:evently/provider/theme_provider.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:evently/utils/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var providerLanguage = Provider.of<AppLanguageProvider>(context);
    var providerTheme = Provider.of<AppThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryBlue,
          toolbarHeight: 160,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
          title: Row(
            children: [
              Image.asset(AssetsManager.routeImage),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mohamed Omar Mahrous Saad Aboughonema',
                      style: AppTextStyle.bold24White,
                    ),
                    Text(
                      'mohamedomarmahroussaadaboughonema@route.com',
                      style: AppTextStyle.medium16White,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                AppLocalizations.of(context)!.language,
                style: AppTextStyle.bold20Black
                    .copyWith(color: Theme.of(context).primaryColorDark),
              ),
            ),
            SpecialDropDownMenu(
                currentCode: providerLanguage.currentLanguageCode,
                text1: AppLocalizations.of(context)!.english,
                text2: AppLocalizations.of(context)!.arabic,
                onTapListTile: providerLanguage.setLanguage,
                code1: 'en',
                code2: 'ar'),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                AppLocalizations.of(context)!.theme,
                style: AppTextStyle.bold20Black
                    .copyWith(color: Theme.of(context).primaryColorDark),
              ),
            ),
            SpecialDropDownMenu(
                currentCode: providerTheme.currentTheme.toString(),
                text1: AppLocalizations.of(context)!.light,
                text2: AppLocalizations.of(context)!.dark,
                onTapListTile: (String code) {
                  if (code == ThemeMode.light.toString()) {
                    providerTheme.setTheme(
                        ThemeMode.light, AppLocalizations.of(context)!.light);
                  } else if (code == ThemeMode.dark.toString()) {
                    providerTheme.setTheme(
                        ThemeMode.dark, AppLocalizations.of(context)!.dark);
                  }
                },
                code1: ThemeMode.light.toString(),
                code2: ThemeMode.dark.toString()),
            Spacer(),
            SpecialElevatedButton(
              onPressed: logout,
              text: AppLocalizations.of(context)!.logout,
              icon: Icon(Icons.logout, color: AppColor.white, size: 20),
              backgroundColor: AppColor.red,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ));
  }
}

void logout() {}
