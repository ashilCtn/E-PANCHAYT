import 'package:cloud_firestore/cloud_firestore.dart';

class CcClassification {
  Future<List<String>> readTypes() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Contact_Classification')
          .get();
      List<String> contactTypes = snapshot.docs
          .map((doc) => doc.data()['Contact_Type'] as String)
          .toList();
      contactTypes.sort();
      print('Contact Types: $contactTypes');
      return contactTypes;
    } catch (e) {
      print('Error fetching contact types: $e');
      return []; // Return an empty list or handle the error as needed
    }
  }
}
