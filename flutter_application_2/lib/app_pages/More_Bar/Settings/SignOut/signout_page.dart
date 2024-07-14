import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/auth/auth_page.dart';
import 'package:flutter_application_2/components/my_button.dart';
// import 'package:flutter_application_2/components/loading.dart';

class SignOutPage extends StatefulWidget {
  const SignOutPage({super.key});

  @override
  State<SignOutPage> createState() => _SignOutPageState();
}

class _SignOutPageState extends State<SignOutPage> {
  final user = FirebaseAuth.instance.currentUser!;

  // void signUserOut() async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: ((context) => const AuthPage())));
  //   } on FirebaseAuthException catch (e) {
  //     print("Error signing out: $e");
  //   }
  // }
  void signUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        // Check if the widget is still mounted
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => const AuthPage())));
      }
    } on FirebaseAuthException catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Out'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pushNamed(context, 'more');
            Navigator.pop(context);
          },
        ),
        // backgroundColor: AppPallete.barAppNav,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed in as : ${user.email!}'),
            const SizedBox(
              height: 10,
            ),
            MyButton(
                onTap: () {
                  signUserOut();
                },
                text: 'Sign Out'),
          ],
        ),
      ),
    );
  }
}
