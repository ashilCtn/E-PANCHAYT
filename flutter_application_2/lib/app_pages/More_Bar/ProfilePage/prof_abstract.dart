import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/services/firestore_register.dart';

class ProfileAbstraction {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> checkProfile() async {
    User? user = _auth.currentUser;

    if (user == null) {
      return false; // User is not signed in
    }

    String? email = user.email;

    if (email != null) {
      try {
        List<String> userEmailList =
            await FireStoreRegister().getAllUserEmails();

        if (!userEmailList.contains(email)) {
          return true; // User email is not in Firestore
        } else {
          return false; // User email is already in Firestore
        }
      } catch (e) {
        print('Error fetching user emails: $e');
        return false; // Error occurred, return false
      }
    } else {
      return false; // User email is null
    }
  }
}
