import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/home_page.dart';
import 'package:flutter_application_2/app_pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user logged in
          if (snapshot.hasData) {
            return HomePage();
            //Navigator.pushNamed(context, 'home');
          }
          //user not logged in
          else {
            return LoginPage();
            //Navigator.pushNamed(context, 'y');
          }
        },
      ),
    );
  }
}
