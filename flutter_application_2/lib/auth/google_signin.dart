import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Renaming the class to avoid naming conflicts with the GoogleSignIn package
class GoogleSignInService {
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Attempt to get the currently authenticated user
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // Check if the sign-in process was canceled or failed
      if (gUser == null) {
        // The user canceled the sign-in
        return null;
      }

      // Obtain the authentication details from the user
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential using the obtained authentication details
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Use the credential to sign in to Firebase
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Handle and log any errors that occur during the sign-in process
      print('Error during Google sign-in: $e');
      return null;
    }
  }
}
