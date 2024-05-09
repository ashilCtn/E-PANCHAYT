// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/about_page.dart';
import 'package:flutter_application_2/app_pages/addnewcontact_page.dart';
import 'package:flutter_application_2/app_pages/auth_page.dart';
import 'package:flutter_application_2/app_pages/contacts_page.dart';
import 'package:flutter_application_2/app_pages/navbar_page.dart';
import 'package:flutter_application_2/app_pages/home_page.dart';
import 'package:flutter_application_2/app_pages/login_page.dart';
import 'package:flutter_application_2/app_pages/profile_page.dart';
import 'package:flutter_application_2/app_pages/signout_page.dart';
import 'package:flutter_application_2/app_pages/regist_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_2/app_pages/updates_page.dart';
import 'package:flutter_application_2/app_pages/addnewupdate_page.dart';
import 'package:flutter_application_2/core/theme/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAppCheck.instance.activate(
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //   androidProvider: AndroidProvider.debug,
  // appleProvider: AppleProvider.appAttest,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      routes: {
        'x': (context) => RegistrationPage(),
        'y': (context) => const LoginPage(),
        'z': (context) => const FunPage(),
        'updates': (context) => const UpdatesPage(),
        'auth': (context) => const AuthPage(),
        'home': (context) => const HomePage(),
        'addNewUpdate': (context) => const AddNewUpdatePage(),
        'contact': (context) => const ContactsPage(),
        'addNewContact': (context) => const AddNewContactPage(),
        'signout': (context) => SignOutPage(),
        'about': (context) => const AboutPage(),
        'profile': (context) => const ProfilePage(),
      },
      home: const AuthPage(), //ContactsPage()
    );
  }
}
