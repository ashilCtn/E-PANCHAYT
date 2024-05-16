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
      print('Checking if document exists for user: ${user.email}');
      DocumentSnapshot docSnapshot =
          await profileCollection.doc('User::${user.email}').get();

      if (docSnapshot.exists) {
        print('Document already exists. Not saving to Firebase.');
        deleteFromFirebase();
      }
      // Serialize family member details into a list of maps
      List<Map<String, dynamic>> serializedData =
          familyMembers.map((member) => member.toMap()).toList();

      // Save serialized data to a single document in Firebase
      await profileCollection
          .doc('User::${user.email}')
          .set({'members': serializedData});
      print('Document saved successfully.');
    } catch (e) {
      print('Error saving to Firebase: $e');
    }
  }

  // Method to retrieve all family members' details from Firebase
  Future<List<FamilyMember>> getFromFirebase() async {
    try {
      print('Fetching document for user: ${user.email}');
      DocumentSnapshot docSnapshot =
          await profileCollection.doc('User::${user.email}').get();

      print('Document fetched: ${docSnapshot.exists}');

      if (docSnapshot.exists) {
        List<dynamic> membersList = docSnapshot.get('members');
        print('Members list retrieved: $membersList');

        List<FamilyMember> familyMembers = membersList.map((member) {
          print('Processing member: $member');
          return FamilyMember(
            name: member['name'],
            relationwithuser: member['relation'],
            aadhaar: member['aadhaar'],
          );
        }).toList();

        return familyMembers;
      } else {
        print('Document does not exist');
        return [];
      }
    } catch (e) {
      print('Error retrieving from Firebase: $e');
      return [];
    }
  }

  Future<void> deleteFromFirebase() async {
    try {
      print('Deleting document for user: ${user.email}');
      await profileCollection.doc('User::${user.email}').delete();
      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document from Firebase: $e');
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
