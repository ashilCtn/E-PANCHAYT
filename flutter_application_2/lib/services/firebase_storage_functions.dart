import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String imageURL = '';

Future<File?> getImageFromGallery(BuildContext context) async {
  try {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  } catch (e) {
    String exceptionAsString = e.toString();
    print(exceptionAsString);
    return null;
  }
}

Future<String> uploadFileForUser(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef =
        storageRef.child("  $userId/uploads/$timestamp-$fileName");
    await uploadRef.putFile(file);
    return await uploadRef.getDownloadURL();
  } catch (e) {
    // print('Error uploading file: $e');
    // Handle the error and return an empty string or handle it accordingly
    return '';
  }
}

Future<String> uploadProfilePicOfContact(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef =
        storageRef.child("Profile Pics/$userId/uploads/$timestamp-$fileName");
    await uploadRef.putFile(file);
    return await uploadRef.getDownloadURL();
  } catch (e) {
    // print('Error uploading profile pic: $e');
    // Handle the error and return an empty string or handle it accordingly
    return '';
  }
}
