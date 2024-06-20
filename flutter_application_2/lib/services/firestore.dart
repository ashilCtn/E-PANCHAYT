import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  //get collections of updates
  final CollectionReference updates =
      FirebaseFirestore.instance.collection('Updates_List');

  //CREATE : add a new update
  Future<void> createNode(
      String userEmail, String node, String node2, String imageURL) {
    String docId = '${userEmail}_${Timestamp.now().millisecondsSinceEpoch}';
    return updates.doc(docId).set({
      'UserEmail': userEmail,
      'News Update Heading': node,
      'News Update Details': node2,
      'ImageURL': imageURL,
      'Date & Time': Timestamp.now(),
    });
  }

  //READ : read updates from DB
  Stream<QuerySnapshot> readNode() {
    final updatesStream =
        updates.orderBy('Date & Time', descending: true).snapshots();
    return updatesStream;
  }

  //UPDATE : update the content
  Future<void> updateNewNode(
      String docID, String newNode, String newNode2, String imageURL) {
    return updates.doc(docID).update({
      'News Update Heading': newNode,
      'News Update Details': newNode2,
      'ImageURL': imageURL,
      'Date & Time': Timestamp.now(),
    });
  }

  //DELETE : delete the update
  Future<void> deleteNode(String docID) {
    return updates.doc(docID).delete();
  }
}
