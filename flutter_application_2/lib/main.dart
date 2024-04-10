import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/functionality_page.dart';
import 'package:flutter_application_2/app_pages/login_page.dart';
import 'package:flutter_application_2/app_pages/regist_page.dart';
import 'package:flutter_application_2/components/my_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'x':(context) => RegistrationPage(),
        'y':(context) =>  LoginPage(),
        'z':(context) => FunPage(),
      },
      home:LoginPage(), 
    );
  }
}
