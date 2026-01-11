import 'package:evently/custom_widgets/custom_alert_dialoge.dart';
import 'package:evently/custom_widgets/special_elevated_button.dart';
import 'package:evently/custom_widgets/special_text_button.dart';
import 'package:evently/custom_widgets/special_text_field.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/model/app_user.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/ui/auth/login/login_screen.dart';
import 'package:evently/ui/home_screen/home_screen.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:evently/utils/asset_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController(text: 'Mohamed Omar');
  var emailController = TextEditingController(text: 'mohamedomar@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var rePasswordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AssetsManager.logo),
              SpecialTextField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.please_enter_name;
                  }
                  return null;
                },
                textColor: Theme.of(context).primaryColorDark,
                borderColor: Theme.of(context).primaryColorLight,
                iconColor: Theme.of(context).primaryColorDark,
                prefixIcon: Icon(Icons.person),
                hintText: AppLocalizations.of(context)!.name,
              ),
              SpecialTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.please_enter_email;
                  }
                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (!emailValid) {
                    return AppLocalizations.of(context)!.please_enter_email;
                  }
                  return null;
                },
                textColor: Theme.of(context).primaryColorDark,
                borderColor: Theme.of(context).primaryColorLight,
                iconColor: Theme.of(context).primaryColorDark,
                prefixIcon: Icon(Icons.email),
                hintText: AppLocalizations.of(context)!.email,
              ),
              SpecialTextField(
                keyboardType: TextInputType.phone,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.please_enter_password;
                  }
                  if (value.trim().length < 6) {
                    return 'password must be at least 6 characters.';
                  }
                  return null;
                },
                textColor: Theme.of(context).primaryColorDark,
                borderColor: Theme.of(context).primaryColorLight,
                iconColor: Theme.of(context).primaryColorDark,
                prefixIcon: Icon(Icons.lock),
                hintText: AppLocalizations.of(context)!.password,
                suffixIcon: Icon(Icons.visibility_off),
              ),
              SpecialTextField(
                keyboardType: TextInputType.number,
                controller: rePasswordController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!
                        .please_enter_re_password;
                  }
                  if (value.trim().length < 6) {
                    return 'password must be at least 6 characters.';
                  }
                  if (value.trim() != passwordController.text.trim()) {
                    return 'passwords do not match.';
                  }
                  return null;
                },
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
      ),
    );
  }

  void createAccount() async {
    if (formKey.currentState!.validate()) {
      CustomAlertDialoge.showLoading(context: context, message: 'Loading...');
      // Proceed with account creation
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        CustomAlertDialoge.hideLoading(context: context);
        CustomAlertDialoge.showMessage(
            context: context,
            message: 'Registered Successfully',
            posActionname: 'OK',
            posAction: () {
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            });
        AppUser appUser = AppUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        FirebaseUtils.addUserToFirestore(appUser);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(appUser);
        print('user registered: ${credential.user?.uid ?? 'no-id'}');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          CustomAlertDialoge.hideLoading(context: context);
          CustomAlertDialoge.showMessage(
            context: context,
            message: 'The password provided is too weak.',
            posActionname: 'OK',
          );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          CustomAlertDialoge.hideLoading(context: context);
          CustomAlertDialoge.showMessage(
            context: context,
            message: 'The account already exists for that email.',
            posActionname: 'OK',
          );
          print('The account already exists for that email.');
        } else if (e.code == 'network-request-failed') {
          CustomAlertDialoge.hideLoading(context: context);
          CustomAlertDialoge.showMessage(
            context: context,
            message: 'Network Error.',
            posActionname: 'OK',
          );
        }
      } catch (e) {
        CustomAlertDialoge.hideLoading(context: context);
        CustomAlertDialoge.showMessage(
          context: context,
          message: e.toString(),
          posActionname: 'OK',
        );
        print(e);
      }
    }
  }
}
