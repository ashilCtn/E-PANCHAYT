import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreRegister {
  Future addNormalUserDetails(String userName, String email, String wardno,
      String mobileno, String password) async {
    await FirebaseFirestore.instance.collection('Normal_Users').add({
      'Username': userName,
      'Email': email,
      'Wardno': wardno,
      'Mobileno': mobileno,
      'Password': password,
    });
  }

  Future<List<Map<String, dynamic>>> getAllNormalUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Normal_Users').get();
    List<Map<String, dynamic>> usersData =
        snapshot.docs.map((doc) => doc.data()).toList();
    return usersData;
  }

  Future<UserData?> getCurrentUserData(String userEmail) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Normal_Users')
        .where('Email', isEqualTo: userEmail)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var userData = snapshot.docs.first.data();
      return UserData(
        userName: userData['Username'],
        emailid: userData['Email'],
        mobileNo: userData['Mobileno'],
        wardNo: userData['Wardno'],
      );
    } else {
      return null;
    }
  }
}

class UserData {
  final String userName;
  final String emailid;
  final String mobileNo;
  final String wardNo;

  UserData({
    required this.userName,
    required this.emailid,
    required this.mobileNo,
    required this.wardNo,
  });
}
