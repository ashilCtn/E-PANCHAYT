import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  //get collections of notes
  final CollectionReference nodes =
      FirebaseFirestore.instance.collection('Updates_List');

  //CREATE : add a new update
  Future<void> createNode(String node, String node2, String imageURL) {
    return nodes.add({
      'News Update Heading': node,
      'News Update Details': node2,
      'ImageURL': imageURL,
      'Date & Time': Timestamp.now(),
    });
  }

  //READ : read an update from DB
  Stream<QuerySnapshot> readNode() {
    final updatesStream =
        nodes.orderBy('Date & Time', descending: true).snapshots();
    return updatesStream;
  }

  //UPDATE :update the content
  Future<void> updateNewNode(
      String docID, String newNode, String newNode2, String imageURL) {
    return nodes.doc(docID).update({
      'News Update Heading': newNode,
      'News Update Details': newNode2,
      'ImageURL': imageURL,
      'Date & Time': Timestamp.now(),
    });
  }

  //DELETE : delete the update
  Future<void> deleteNode(String docID) {
    return nodes.doc(docID).delete();
  }
}
