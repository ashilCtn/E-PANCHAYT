import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/loading.dart';
import 'package:flutter_application_2/components/update_page_textfield.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';
import 'package:flutter_application_2/services/firebase_storage_functions.dart';
import 'package:flutter_application_2/services/firestore.dart';

class AddNewUpdatePage extends StatefulWidget {
  final String? docID; // Declare docID as a parameter
  const AddNewUpdatePage({super.key, this.docID});

  @override
  State<AddNewUpdatePage> createState() => _AddNewUpdatePageState();
}

class _AddNewUpdatePageState extends State<AddNewUpdatePage> {
  final FireStoreService fireStoreService = FireStoreService();
  // final UpdatesPage updatesPage = const UpdatesPage();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  String imageURL = ''; // Declare imageURL variable
  File? image;

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  void selectImage() async {
    Loader.showLoadingDialog(context);
    final selectedImage = await getImageFromGallery(context);
    if (selectedImage != null) {
      setState(() {
        image = selectedImage;
      });
      // print("Image Not @@@@@@@@@@@@@@@@@@@@@@@@@@@@@Selected\n");
      imageURL = await uploadFileForUser(selectedImage);
      // print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${imageURL}");
      // print(imageURL);
    } else {
      print("Image Not Selected\n");
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'z');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (widget.docID == null) {
                // Access docID from widget
                fireStoreService.createNode(
                    titleController.text, contentController.text, imageURL);
              } else {
                fireStoreService.updateNewNode(
                    widget.docID!, // Access docID from widget
                    titleController.text,
                    contentController.text,
                    imageURL);
              }
              Navigator.pushNamed(context, 'z');
              titleController.clear();
              contentController.clear();
            },
            icon: const Icon(Icons.done_all_rounded),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(
                          10), // Match the DottedBorder's radius
                      child: SizedBox(
                        // Set the width to match the DottedBorder's size
                        height: 150,
                        child: Image.file(
                          image!,
                          fit: BoxFit.fill, // Set fit to cover the area
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: DottedBorder(
                        color: AppPallete.borderColor,
                        dashPattern: const [10, 4],
                        radius: const Radius.circular(10),
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        child: const SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Select Your Image',
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              UpdatePageTextField(
                controller: titleController,
                hintText: 'Headline',
              ),
              const SizedBox(
                height: 10,
              ),
              UpdatePageTextField(
                controller: contentController,
                hintText: 'Details',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
