// ignore: file_names
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/More_Bar/Contacts_Page/cc_classification.dart';
import 'package:flutter_application_2/app_pages/Services_Bar/Complaints/predef_text.dart';
import 'package:flutter_application_2/components/loading.dart';
import 'package:flutter_application_2/components/update_page_textfield.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';
import 'package:flutter_application_2/services/firebase_storage_functions.dart';
import 'package:flutter_application_2/services/firestore_contacts_crud.dart';

class AddNewContactPage extends StatefulWidget {
  final String? docID; // Declare docID as a parameter
  const AddNewContactPage({Key? key, this.docID}) : super(key: key);

  @override
  State<AddNewContactPage> createState() => _AddNewContactPageState();
}

class _AddNewContactPageState extends State<AddNewContactPage> {
  CcClassification ccClassification = CcClassification();

  String selectedType = 'All';
  List<String> categories = ['All'];

  final FireStoreServiceContacts fireStoreService = FireStoreServiceContacts();
  final name = TextEditingController();
  final designation = TextEditingController();
  final number = TextEditingController();
  String imageURL =
      'https://img.freepik.com/free-vector/404-error-with-landscape-concept-illustration_114360-7898.jpg';
  File? image;

  @override
  void initState() {
    super.initState();
    // Initialize categories asynchronously
    Future.delayed(Duration.zero, () async {
      categories = await ccClassification.readTypes();
      setState(() {}); // Update the state to reflect the loaded categories
      if (widget.docID != null) {
        fetchContactDetails(widget.docID!);
      }
    });
  }

  void fetchContactDetails(String docID) async {
    // Fetch existing contact details using docID and populate fields
    final contact = await fireStoreService.getContactDetails(docID);
    setState(() {
      name.text = contact.name;
      designation.text = contact.designation;
      number.text = contact.number;
      imageURL = contact.imageURL;
    });
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    designation.dispose();
  }

  void selectImage() async {
    Loader.showLoadingDialog(context);
    final selectedImage = await getImageFromGallery(context);
    if (selectedImage != null) {
      setState(() {
        image = selectedImage;
      });
      imageURL = await uploadProfilePicOfContact(selectedImage);
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
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              print(widget.docID);
              if (widget.docID == null) {
                // Access docID from widget
                fireStoreService.createNewContact(name.text, designation.text,
                    number.text, imageURL, selectedType);
              } else {
                fireStoreService.updateNewContact(
                    widget.docID!, // Access docID from widget
                    name.text,
                    designation.text,
                    number.text,
                    imageURL,
                    selectedType);
              }
              Navigator.pop(context);
              name.clear();
              designation.clear();
              number.clear();
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
                          100), // Match the DottedBorder's radius
                      child: SizedBox(
                        width:
                            150, // Set the width to match the DottedBorder's size
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
                        radius: const Radius.circular(100),
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        child: const SizedBox(
                          height: 150,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.person_alt_circle,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Contact Profile',
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              UpdatePageTextField(
                controller: name,
                hintText: 'Name',
              ),
              const SizedBox(
                height: 10,
              ),
              UpdatePageTextField(
                controller: designation,
                hintText: 'Designation',
              ),
              const SizedBox(
                height: 10,
              ),
              UpdatePageTextField(
                controller: number,
                hintText: 'Phone',
              ),
              ListTile(
                title: PreDefText(
                  label: 'Contact\nType',
                  dataValue: '',
                ),
                trailing: DropdownButton<String>(
                  value: selectedType,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedType = newValue!;
                    });
                  },
                  items:
                      categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
