import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/showupdate_popup.dart';
import 'package:flutter_application_2/core/RBAC/role_retrieve.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';
import 'package:flutter_application_2/services/firestore.dart';
import 'package:flutter_application_2/services/firestore_register.dart';

class UpdatesPage extends StatefulWidget {
  const UpdatesPage({super.key});

  @override
  State<UpdatesPage> createState() => _UpdatesPageState();
}

class _UpdatesPageState extends State<UpdatesPage> {
  final FireStoreService fireStoreService = FireStoreService();
  FireStoreRegister fireStoreRegister = FireStoreRegister();
  final user = FirebaseAuth.instance.currentUser!;

  final TextEditingController textController = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  String imageURL = '';

  //Role Retrieved
  String role = '';

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  Future<void> getUserRole() async {
    AccessRole accessRole = AccessRole();
    String retrievedRole = await accessRole.getUserRole();
    if (mounted) {
      setState(() {
        role = retrievedRole;
      });
    }
  }

  @override
  void dispose() {
    textController.dispose();
    textController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News & Events',
        ),
        centerTitle: true,
        backgroundColor: AppPallete.barAppNav,
        automaticallyImplyLeading: false,
        actions: [
          if (role == 'admin' ||
              role == 'superuser') // Conditional check for role
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'addNewUpdate');
              },
              icon: const Icon(CupertinoIcons.add_circled),
            ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.readNode(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List updatesList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: updatesList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = updatesList[index];
                String docID = document.id;
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String updateTextHeading = data['News Update Heading'];
                String updateTextDetails = data['News Update Details'];
                String imageURL = data['ImageURL'];

                return GestureDetector(
                  onTap: () {
                    // POP UP of the list
                    showCustomDialog(context, updateTextHeading,
                        updateTextDetails, imageURL);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        AppPallete.gradient3,
                        AppPallete.gradient2,
                        AppPallete.gradient1
                      ]),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                        child: Container(
                          width: 100, // Adjust the width as needed
                          height: 100, // Adjust the height as needed
                          color: Colors.grey, // Placeholder color
                          child: imageURL.isNotEmpty
                              ? Image.network(
                                  imageURL,
                                  fit: BoxFit.fill,
                                )
                              : const Icon(
                                  Icons.add_photo_alternate,
                                  // color: Colors.white,
                                ),
                        ),
                      ),
                      title: Text(
                        updateTextHeading,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                      subtitle: Text(
                        updateTextDetails,
                        maxLines: 3, // Limiting to 3 lines
                        overflow: TextOverflow
                            .ellipsis, // Displaying ellipsis (...) if overflow
                        style: const TextStyle(
                          color: Colors.white, // Text color
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (role == 'admin' || role == 'superuser')
                            PopupMenuButton(
                              icon: const Icon(
                                Icons.more_vert,
                                // color: Colors.white, // Icon color
                              ),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                PopupMenuItem(
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.edit,
                                      // color: Colors.black, // Icon color
                                    ),
                                    title: const Text('Edit'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, 'addNewUpdate');
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.delete,
                                      // color: Colors.black, // Icon color
                                    ),
                                    title: const Text('Delete'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      fireStoreService.deleteNode(docID);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(
                              width:
                                  8), // Add spacing between the PopupMenuButton and the image box
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No New Updates..."));
          }
        },
      ),
    );
  }
}
