import 'package:evently/custom_widgets/custom_alert_dialoge.dart';
import 'package:evently/custom_widgets/selection_widget.dart';
import 'package:evently/custom_widgets/special_elevated_button.dart';
import 'package:evently/custom_widgets/special_text_button.dart';
import 'package:evently/custom_widgets/special_text_field.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/provider/events_list_provider.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/ui/auth/forget_password/forget_password.dart';
import 'package:evently/ui/auth/register/register_screen.dart';
import 'package:evently/ui/home_screen/home_screen.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:evently/utils/asset_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: 'mohamedomar@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login),
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
                keyboardType: TextInputType.number,
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
                  SelectionWidget(
                      widget1: Image.asset(AssetsManager.america),
                      widget2: Image.asset(AssetsManager.egypt)),
                  Spacer()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void forgetPassword() {}

  void login() async {
    if (formKey.currentState!.validate()) {
      CustomAlertDialoge.showLoading(context: context, message: 'Loading...');
      // Proceed with account creation
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFirestore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        var eventsListProvider =
            Provider.of<EventsListProvider>(context, listen: false);
        CustomAlertDialoge.hideLoading(context: context);
        CustomAlertDialoge.showMessage(
            context: context,
            message: 'Login Successfully',
            posActionname: 'OK',
            posAction: () {
              eventsListProvider.changeSelectedIndex(
                  0,
                  userProvider.currentUser!.id ??
                      'nullable which is impossible');
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
        print('User logged in: ${credential.user?.uid ?? 'no-id'}');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          CustomAlertDialoge.hideLoading(context: context);
          CustomAlertDialoge.showMessage(
            context: context,
            message: 'No user found for that email.',
            posActionname: 'OK',
          );
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          CustomAlertDialoge.hideLoading(context: context);
          CustomAlertDialoge.showMessage(
            context: context,
            message: 'Wrong password provided for that user.',
            posActionname: 'OK',
          );
          print('Wrong password provided for that user.');
        } else if (e.code == 'invalid-credential') {
          CustomAlertDialoge.hideLoading(context: context);
          CustomAlertDialoge.showMessage(
            context: context,
            message: 'email not found.',
            posActionname: 'OK',
          );
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

  void loginWithGoogle() {}
}
