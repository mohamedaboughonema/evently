import 'package:evently/provider/language_provider.dart';
import 'package:evently/provider/theme_provider.dart';
import 'package:evently/ui/auth/forget_password/forget_password.dart';
import 'package:evently/ui/auth/login/login_screen.dart';
import 'package:evently/ui/auth/register/register_screen.dart';
import 'package:evently/ui/home_screen/add_event/add_event.dart';
import 'package:evently/ui/home_screen/home_screen.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AppLanguageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AppThemeProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var providerLanguage = Provider.of<AppLanguageProvider>(context);
    var providerTheme = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(providerLanguage.currentLanguageCode),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: providerTheme.currentTheme, // ThemeMode.system,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        AddEvent.routeName: (context) => const AddEvent(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        ForgetPassword.routeName: (context) => const ForgetPassword(),
      },
    );
  }
}
