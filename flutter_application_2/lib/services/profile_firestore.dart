import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreServiceProfile {
  final user = FirebaseAuth.instance.currentUser!;
  // Collection reference
  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('Profile_Details');

  // Method to save family members' details to Firebase
  Future<void> saveToFirebase(List<FamilyMember> familyMembers) async {
    try {
      // Serialize family member details into a list of maps
      List<Map<String, dynamic>> serializedData =
          familyMembers.map((member) => member.toMap()).toList();

      // Save serialized data to a single document in Firebase
      await profileCollection
          .doc('${user.email}  ')
          .set({'members': serializedData});
    } catch (e) {
      print('Error saving to Firebase: $e');
    }
  }
}

class FamilyMember {
  final String name;
  final String relationwithuser;
  final String aadhaar;

  FamilyMember(
      {required this.name,
      required this.relationwithuser,
      required this.aadhaar});

  // Convert FamilyMember object to a Map for Firebase storage
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'relation': relationwithuser,
      'aadhaar': aadhaar,
    };
  }
}
