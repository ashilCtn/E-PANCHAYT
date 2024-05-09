import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServiceContacts {
  //get collections of notes
  final CollectionReference contactNodes =
      FirebaseFirestore.instance.collection('Contact_List');

  //CREATE : add a new update
  Future<void> createNewContact(
      String node, String node2, String node3, String imageURL) {
    return contactNodes.add({
      'Contact Name': node,
      'Contact Designation': node2,
      'Contact Number': node3,
      'Profile Pic': imageURL,
      'Date & Time': Timestamp.now(),
    });
  }

  //READ : read an update from DB
  Stream<QuerySnapshot> readAllContacts() {
    final updatesStream =
        contactNodes.orderBy('Contact Name', descending: false).snapshots();
    return updatesStream;
  }

  //UPDATE :update the content
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

  //DELETE : delete the update
  Future<void> deleteContact(String docID) {
    return contactNodes.doc(docID).delete();
  }
}
