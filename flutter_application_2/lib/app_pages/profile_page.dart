import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed in as : ${user.email!}'),
            const SizedBox(
              height: 10,
            ),
            /*MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: const Color.fromARGB(129, 13, 5, 5),
              child: const Text('Sign Out'),
            ),*/
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
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
