import 'package:firebase_auth/firebase_auth.dart';

class ProfileAbstraction {
  User? user = FirebaseAuth.instance.currentUser;

  Future<bool> checkProfile() async {
    if (user == null) {
      return false; // User is not signed in
    }

    String? email = user!.email;
    if (email != null) {
      // You can perform further checks on the email or user profile here
      return true;
    } else {
      return false;
    }
  }
}
