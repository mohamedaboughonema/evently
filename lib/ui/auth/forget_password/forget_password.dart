import 'package:evently/custom_widgets/special_elevated_button.dart';
import 'package:evently/utils/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPassword extends StatelessWidget {
  static const String routeName = 'ForgetPassword';
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.forget_password),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AssetsManager.forgetPassword),
            SpecialElevatedButton(
                onPressed: resetPassword,
                text: AppLocalizations.of(context)!.reset_password,
                centerText: true),
          ],
        ),
      ),
    );
  }
}

void resetPassword() {}
