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
    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef = storageRef.child("$userId/uploads/$timestamp-$fileName");
    await uploadRef.putFile(file);
    imageURL = await uploadRef.getDownloadURL();
    return imageURL;
  } catch (e) {
    // print(e);
    return 'https://imgs.search.brave.com/gazFCGOe9xDFa6FkkqVDEfgHJLnWx7A6mcXK76nYVq8/rs:fit:500:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAwLzg5LzU1LzE1/LzM2MF9GXzg5NTUx/NTk2X0xkSEFaUnd6/M2k0RU00SjBOSE5I/eTJoRVVZRGZYYzBq/LmpwZw'; // Return an empty string or handle the error accordingly
  }
}
