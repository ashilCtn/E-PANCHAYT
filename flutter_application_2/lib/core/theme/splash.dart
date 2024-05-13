import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/auth/auth_page.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedSplashScreen(
        splash: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'lib/img/white_splash2.png',
                  height: 600,
                  width: 600,
                ),
                const SizedBox(height: 20),
                const Text(
                  'e-Panchayat',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
        nextScreen: const AuthPage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: AppPallete.backgroundColor,
        duration: 1500,
      ),
    );
  }
}
