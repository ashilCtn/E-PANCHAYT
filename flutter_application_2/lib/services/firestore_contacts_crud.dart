import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreServiceContacts {
  // Get collections of notes
  final CollectionReference contactNodes =
      FirebaseFirestore.instance.collection('Contact_List');

  // Get the current user's email
  String? getCurrentUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.email;
  }

  // Generate a unique document ID using email and timestamp
  String generateUniqueDocID(String email) {
    return '${email}_${DateTime.now().millisecondsSinceEpoch}';
  }

  // CREATE: Add a new contact
  Future<void> createNewContact(
      String node, String node2, String node3, String imageURL) async {
    String? email = getCurrentUserEmail();
    if (email != null) {
      String uniqueDocID = generateUniqueDocID(email);
      return contactNodes.doc(uniqueDocID).set({
        'Contact Name': node,
        'Contact Designation': node2,
        'Contact Number': node3,
        'Profile Pic': imageURL,
        'Date & Time': Timestamp.now(),
      });
    } else {
      throw Exception('No logged in user');
    }
  }

  // READ: Read all contacts
  Stream<QuerySnapshot> readAllContacts() {
    return contactNodes.orderBy('Contact Name', descending: false).snapshots();
  }

  // UPDATE: Update the contact
  Future<void> updateNewContact(String docID, String newNode, String newNode2,
      String newNode3, String imageURL) {
    return contactNodes.doc(docID).update({
      'Contact Name': newNode,
      'Contact Designation': newNode2,
      'Contact Number': newNode3,
      'Profile Pic': imageURL,
      'Date & Time': Timestamp.now(),
    });
  }

  // DELETE: Delete the contact
  Future<void> deleteContact(String docID) {
    return contactNodes.doc(docID).delete();
  }
}
