import 'package:firebase_database/firebase_database.dart';

class RealTimeFirebase {
  final _databaseReference = FirebaseDatabase.instance;

  Future<void> realTimeCreate({
    required String complaintID,
    required String userName,
    required String emailID,
    required String contact,
    required String subject,
    required String cType,
    required String detailedComplaint,
    required String imageURL,
    required String supportLike,
  }) async {
    // Prepare data
    Map<String, dynamic> complaintData = {
      'Username': userName,
      'emailID': emailID,
      'Contact': contact,
      'Type': cType,
      'subject': subject,
      'Complaint_Explained': detailedComplaint,
      'Image_URL': imageURL,
      'support': supportLike,
      'likes': [], // Add an empty list for likes
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

  Future<Map<String, Map<String, dynamic>>> realTimeRead({
    required String cType,
  }) async {
    Map<String, Map<String, dynamic>> result = {};

    try {
      DatabaseReference ref = _databaseReference.ref('Complaints_List');
      DatabaseEvent event =
          await ref.orderByChild('Type').equalTo(cType).once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        if (snapshot.value is Map<dynamic, dynamic>) {
          Map<dynamic, dynamic> complaints =
              snapshot.value as Map<dynamic, dynamic>;
          complaints.forEach((key, value) {
            result[key] = Map<String, dynamic>.from(value);
          });
        } else if (snapshot.value is List<dynamic>) {
          List<dynamic> complaints = snapshot.value as List<dynamic>;
          for (var i = 0; i < complaints.length; i++) {
            if (complaints[i] != null) {
              result[i.toString()] = Map<String, dynamic>.from(complaints[i]);
            }
          }
        }
      } else {
        print('No complaints found for type $cType.');
      }
    } catch (error) {
      print('Error reading complaints: $error');
    }
    print(result);
    return result;
  }

  Future<void> updateSupportCount({
    required String complaintId,
    required String emailId,
    required bool isLiked,
  }) async {
    try {
      DatabaseReference complaintRef =
          _databaseReference.ref('Complaints_List').child(complaintId);
      DataSnapshot snapshot = await complaintRef.child('likes').get();

      List<dynamic> likes = snapshot.value != null
          ? List<dynamic>.from(snapshot.value as List<dynamic>)
          : [];

      if (isLiked) {
        if (!likes.contains(emailId)) {
          likes.add(emailId);
        }
      } else {
        likes.remove(emailId);
      }

      int newSupportCount = likes.length;

      await complaintRef.update({
        'support': newSupportCount.toString(),
        'likes': likes,
      });

      print('Support count updated successfully!');
    } catch (e) {
      print('Error updating support count: $e');
      // Handle error as needed
    }
  }
}
