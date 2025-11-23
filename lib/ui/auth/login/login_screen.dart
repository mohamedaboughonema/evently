import 'package:evently/custom_widgets/special_elevated_button.dart';
import 'package:evently/custom_widgets/special_text_button.dart';
import 'package:evently/custom_widgets/special_text_field.dart';
import 'package:evently/ui/auth/forget_password/forget_password.dart';
import 'package:evently/ui/auth/register/register_screen.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:evently/utils/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login),
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
            Container(
              alignment: Alignment.centerRight,
              child: SpecialTextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(ForgetPassword.routeName);
                  },
                  text: AppLocalizations.of(context)!.forget_password),
            ),
            SpecialElevatedButton(
                onPressed: login,
                text: AppLocalizations.of(context)!.login,
                centerText: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.do_not_have_an_account,
                    style: AppTextStyle.medium16Black
                        .copyWith(color: Theme.of(context).primaryColorDark)),
                SpecialTextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(RegisterScreen.routeName);
                    },
                    text: AppLocalizations.of(context)!.create_account)
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    indent: 50,
                    endIndent: 10,
                    color: AppColor.primaryBlue,
                  ),
                ),
                Text(AppLocalizations.of(context)!.or,
                    style: AppTextStyle.medium16Primary),
                Expanded(
                  child: Divider(
                    indent: 10,
                    endIndent: 50,
                    color: AppColor.primaryBlue,
                  ),
                ),
              ],
            ),
            SpecialElevatedButton(
              onPressed: loginWithGoogle,
              textColor: AppColor.primaryBlue,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              icon: Image.asset(
                AssetsManager.iconGoogle,
                width: 20,
                height: 20,
              ),
              text: AppLocalizations.of(context)!.login_with_google,
              centerText: true,
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

void forgetPassword() {}

void login() {}

void loginWithGoogle() {}
