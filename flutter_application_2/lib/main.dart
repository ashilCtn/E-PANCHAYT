import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/More_Bar/Admin_Control/admin_control_page.dart';
import 'package:flutter_application_2/app_pages/More_Bar/Admin_Control/Remove_User/remove_user.dart';
import 'package:flutter_application_2/app_pages/More_Bar/about_page.dart';
import 'package:flutter_application_2/app_pages/More_Bar/addnewcontact_page.dart';
import 'package:flutter_application_2/app_pages/More_Bar/more_page.dart';
import 'package:flutter_application_2/app_pages/More_Bar/profile_update.dart';
import 'package:flutter_application_2/app_pages/More_Bar/settings_page.dart';
import 'package:flutter_application_2/app_pages/More_Bar/Admin_Control/superuser_page.dart';
import 'package:flutter_application_2/auth/auth_page.dart';
import 'package:flutter_application_2/app_pages/More_Bar/contacts_page.dart';
import 'package:flutter_application_2/app_pages/navbar_page.dart';
import 'package:flutter_application_2/app_pages/login_page.dart';
import 'package:flutter_application_2/app_pages/More_Bar/profile_page.dart';
import 'package:flutter_application_2/app_pages/More_Bar/signout_page.dart';
import 'package:flutter_application_2/app_pages/regist_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_2/app_pages/Updates_Bar/updates_page.dart';
import 'package:flutter_application_2/app_pages/Updates_Bar/addnewupdate_page.dart';
// import 'package:flutter_application_2/core/theme/splash.dart';
import 'package:flutter_application_2/core/theme/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.currentTheme,
      routes: {
        'y': (context) => const LoginPage(),
        'x': (context) => RegistrationPage(),
        'z': (context) => const FunPage(),
        'updates': (context) => const UpdatesPage(),
        'auth': (context) => const AuthPage(),
        'addNewUpdate': (context) => const AddNewUpdatePage(),
        'contact': (context) => const ContactsPage(),
        'addNewContact': (context) => const AddNewContactPage(),
        'about': (context) => const AboutPage(),
        'more': (context) => const MoreMainPage(),
        'profile': (context) => const ProfilePage(),
        'signout': (context) => const SignOutPage(),
        'settings': (context) => const SettingsPage(),
        'profileupdate': (context) => const ProfileUpdatePage(),
        'adminlvl': (context) => const AdminControls(),
        'superuser': (context) => SuperUserPage(),
        'removeuser': (context) => const UserRemoval(),
      },
      home: const AuthPage(),
    );
  }
}
