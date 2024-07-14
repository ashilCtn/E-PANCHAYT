import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/Services_Bar/Complaints/complaint_id.dart';
import 'package:flutter_application_2/app_pages/Services_Bar/Complaints/firebase_service.dart';
import 'package:flutter_application_2/app_pages/Services_Bar/Complaints/predef_text.dart';
import 'package:flutter_application_2/components/loading.dart';
import 'package:flutter_application_2/components/update_page_textfield.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';
import 'package:flutter_application_2/services/firebase_storage_functions.dart';

import '../../../services/firestore_register.dart';

class ComplaintRegistration extends StatefulWidget {
  const ComplaintRegistration({super.key, this.docID});
  final String? docID;

  @override
  _ComplaintRegistrationState createState() => _ComplaintRegistrationState();
}

class _ComplaintRegistrationState extends State<ComplaintRegistration> {
  final subject = TextEditingController();
  final detailedContent = TextEditingController();
  String complaintID = '';
  String userName = '';
  String emailID = '';
  String contactNo = '';
  String imageURL =
      'https://img.freepik.com/free-vector/404-error-with-landscape-concept-illustration_114360-7898.jpg';

  String selectedType = 'Private';
  final List<String> categories = ['Private', 'Public'];

  FireStoreRegister fireStoreRegister = FireStoreRegister();
  RealTimeFirebase realTimeFirebase = RealTimeFirebase();
  final user = FirebaseAuth.instance.currentUser!;

  void getUserData() async {
    String? currentUserEmail = user.email;
    if (currentUserEmail != null) {
      UserData? userData =
          await fireStoreRegister.getCurrentUserData(currentUserEmail);
      if (userData != null) {
        setState(() {
          userName = userData.userName;
          emailID = userData.emailid;
          contactNo = userData.mobileNo;
        });
        print(userData);
      }
    }
  }

  void generateComplaintID() async {
    ComplaintMGR complaintMGR = ComplaintMGR();
    complaintID = await complaintMGR.incrementAndUpdateComplaintID();
  }

  @override
  void initState() {
    getUserData();
    generateComplaintID();
    super.initState();
  }

  File? image;

  void selectImage() async {
    Loader.showLoadingDialog(context);
    final selectedImage = await getImageFromGallery(context);
    if (selectedImage != null) {
      setState(() {
        image = selectedImage;
      });
      imageURL = await uploadFileForUser(selectedImage);
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
        actions: [
          IconButton(
            onPressed: () async {
              realTimeFirebase.realTimeCreate(
                  complaintID: complaintID,
                  userName: userName,
                  emailID: emailID,
                  contact: contactNo,
                  subject: subject.text,
                  cType: selectedType,
                  detailedComplaint: detailedContent.text,
                  imageURL: imageURL,
                  supportLike: '0');
              realTimeFirebase.realTimeRead(cType: 'Public');
              Navigator.pop(context);
              subject.clear();
              detailedContent.clear();
            },
            icon: const Icon(Icons.done_all_rounded),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 150,
                        child: Image.file(
                          image!,
                          fit: BoxFit.fill,
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
                              SizedBox(height: 15),
                              Text(
                                'Select Your Image',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              PreDefText(
                label: 'Complaint ID',
                dataValue: complaintID,
              ),
              const SizedBox(height: 10),
              PreDefText(
                label: 'Username',
                dataValue: userName,
              ),
              const SizedBox(height: 10),
              PreDefText(
                label: 'Email ID',
                dataValue: emailID,
              ),
              const SizedBox(height: 10),
              PreDefText(
                label: 'Contact Number',
                dataValue: contactNo,
              ),
              const SizedBox(height: 10),
              //Create a drop down list here
              ListTile(
                title: PreDefText(
                  label: 'Type of Issue',
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
              UpdatePageTextField(
                controller: subject,
                hintText: 'Subject',
              ),
              const SizedBox(height: 10),
              UpdatePageTextField(
                controller: detailedContent,
                hintText: 'Detailed Complaint/Suggestion',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
