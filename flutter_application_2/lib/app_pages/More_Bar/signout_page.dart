import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/loading.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';

class SignOutPage extends StatefulWidget {
  const SignOutPage({super.key});

  @override
  State<SignOutPage> createState() => _SignOutPageState();
}

class _SignOutPageState extends State<SignOutPage> {
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() async {
    try {
      Loader.showLoadingDialog(context);
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/');
    } on FirebaseAuthException catch (e) {
      // An error occurred while signing out.
      print("Error signing out: $e");
      // You can handle the error here, for example, showing an error message to the user.
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
            Navigator.pushNamed(context, 'more');
          },
        ),
        backgroundColor: AppPallete.barAppNav,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed in as : ${user.email!}'),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                signUserOut();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        AppPallete.gradient1,
                        AppPallete.gradient2,
                        AppPallete.gradient3
                      ]),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                      child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
