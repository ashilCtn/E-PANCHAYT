import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintMGR {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<String> incrementAndUpdateComplaintID() async {
    try {
      // Get the reference to the document in the Complaint_MGR collection
      DocumentReference docRef = firebaseFirestore
          .collection('Complaint_MGR')
          .doc('923evq03qfU6SSeyxbBf');

      // Fetch the document snapshot
      DocumentSnapshot docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // Cast data to Map<String, dynamic> to access fields
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          // Retrieve the Complaint_ID field and convert it to an integer
          String temp = data['Complaint_ID'] ?? 0;
          int complaintID = int.tryParse(temp) ?? 0;
          // Increment the complaint ID (if needed)
          int newComplaintID = complaintID + 1;

          String updatedComplaintID = newComplaintID.toString();
          // Update the Complaint_ID field in the document (optional)
          await docRef.update({'Complaint_ID': updatedComplaintID});

          // Return the new complaint ID
          return updatedComplaintID;
        } else {
          throw Exception('Document data is null or not a Map');
        }
      } else {
        // Document does not exist
        throw Exception('Document does not exist');
      }
    } catch (e) {
      // Handle errors
      print('Error fetching document: $e');
      throw e;
    }
  }
}
