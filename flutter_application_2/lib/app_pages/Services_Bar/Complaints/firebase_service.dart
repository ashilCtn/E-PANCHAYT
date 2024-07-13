import 'package:firebase_database/firebase_database.dart';

class RealTimeFirebase {
  final _databaseReference = FirebaseDatabase.instance;

  Future<void> realTimeCreate(
      {required String complaintID,
      required String userName,
      required String emailID,
      required String contact,
      required String subject,
      required String cType,
      required String detailedComplaint,
      required String imageURL}) async {
    // Prepare data
    Map<String, String> complaintData = {
      'Username': userName,
      'emailID': emailID,
      'Contact': contact,
      'Type': cType,
      'subject': subject,
      'Complaint_Explained': detailedComplaint,
      'Image_URL': imageURL
    };

    try {
      // Add data to Realtime Database
      await _databaseReference
          .ref('Complaints_List')
          .child(complaintID)
          .set(complaintData);
      print('Complaint added successfully!');
    } catch (error) {
      print('Error adding complaint: $error');
    }
  }

  Future<Map<String, Map<String, dynamic>>> realTimeRead(
      {required String cType}) async {
    Map<String, Map<String, dynamic>> result = {};

    try {
      DatabaseReference ref = _databaseReference.ref('Complaints_List');
      DatabaseEvent event =
          await ref.orderByChild('Type').equalTo(cType).once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        Map<dynamic, dynamic> complaints =
            snapshot.value as Map<dynamic, dynamic>;
        complaints.forEach((key, value) {
          result[key] = Map<String, dynamic>.from(value);
        });
      } else {
        print('No complaints found for type $cType.');
      }
    } catch (error) {
      print('Error reading complaints: $error');
    }
    return result;
  }
}
