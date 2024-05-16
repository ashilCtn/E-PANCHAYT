import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/services/firestore_register.dart';

class AccessRole {
  String role = '';
  FireStoreRegister fireStoreRegister = FireStoreRegister();
  final user = FirebaseAuth.instance.currentUser!;

  Future<String> getUserRole() async {
    String? currentUserEmail = user.email; // Replace with the actual email
    // print('########${user}');
    if (currentUserEmail != null) {
      UserData? userData =
          await fireStoreRegister.getCurrentUserData(currentUserEmail);
      if (userData != null) {
        role = userData.role;
        // print(role);
      }
      return role;
    } else {
      return role;
    }
  }
}
