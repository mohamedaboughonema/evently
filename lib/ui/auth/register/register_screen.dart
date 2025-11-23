import 'package:evently/custom_widgets/special_elevated_button.dart';
import 'package:evently/custom_widgets/special_text_button.dart';
import 'package:evently/custom_widgets/special_text_field.dart';
import 'package:evently/ui/auth/login/login_screen.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:evently/utils/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'RegisterScreen';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AssetsManager.logo),
            SpecialTextField(
              textColor: Theme.of(context).primaryColorDark,
              borderColor: Theme.of(context).primaryColorLight,
              iconColor: Theme.of(context).primaryColorDark,
              prefixIcon: Icon(Icons.person),
              hintText: AppLocalizations.of(context)!.name,
            ),
            SpecialTextField(
              textColor: Theme.of(context).primaryColorDark,
              borderColor: Theme.of(context).primaryColorLight,
              iconColor: Theme.of(context).primaryColorDark,
              prefixIcon: Icon(Icons.email),
              hintText: AppLocalizations.of(context)!.email,
            ),
            SpecialTextField(
              textColor: Theme.of(context).primaryColorDark,
              borderColor: Theme.of(context).primaryColorLight,
              iconColor: Theme.of(context).primaryColorDark,
              prefixIcon: Icon(Icons.lock),
              hintText: AppLocalizations.of(context)!.password,
              suffixIcon: Icon(Icons.visibility_off),
            ),
            SpecialTextField(
              textColor: Theme.of(context).primaryColorDark,
              borderColor: Theme.of(context).primaryColorLight,
              iconColor: Theme.of(context).primaryColorDark,
              prefixIcon: Icon(Icons.lock),
              hintText: AppLocalizations.of(context)!.re_password,
              suffixIcon: Icon(Icons.visibility_off),
            ),
            SpecialElevatedButton(
                onPressed: createAccount,
                text: AppLocalizations.of(context)!.create_account,
                centerText: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.already_have_account,
                    style: AppTextStyle.medium16Black
                        .copyWith(color: Theme.of(context).primaryColorDark)),
                SpecialTextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    text: AppLocalizations.of(context)!.login)
              ],
            ),
            Row(
              children: [
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColor.primaryBlue, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AssetsManager.america),
                      SizedBox(width: 8),
                      Image.asset(AssetsManager.egypt),
                    ],
                  ),
                ),
                Spacer()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void createAccount() {}
