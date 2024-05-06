import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/showupdate_popup.dart';
import 'package:flutter_application_2/services/firebase_storage_functions.dart';
import 'package:flutter_application_2/services/firestore.dart';

class UpdatesPage extends StatefulWidget {
  const UpdatesPage({super.key});

  @override
  State<UpdatesPage> createState() => _UpdatesPageState();
}

class _UpdatesPageState extends State<UpdatesPage> {
  final FireStoreService fireStoreService = FireStoreService();
  final TextEditingController textController = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  String imageURL = '';

  void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller:
                  textController, // Assuming textController1 is declared for the first TextField
              decoration: const InputDecoration(
                  labelText: 'Title'), // Optional: Add a label
            ),
            TextField(
              controller:
                  textController2, // Assuming textController2 is declared for the second TextField
              decoration: const InputDecoration(
                  labelText: 'Details'), // Optional: Add a label
            ),
            const SizedBox(
              height: 5,
            ),
            IconButton(
              onPressed: () async {
                File? selectedImage = await getImageFromGallery(context);
                if (selectedImage != null) {
                  imageURL = await uploadFileForUser(selectedImage);
                  // print(success);
                } else {
                  imageURL =
                      'https://imgs.search.brave.com/fXArEBHCg1XnRCIrQhgRljgvjO2sGwDAgvd7EkavsrM/rs:fit:500:0:0/g:ce/aHR0cHM6Ly93d3cu/cHVibGljZG9tYWlu/cGljdHVyZXMubmV0/L3BpY3R1cmVzLzI4/MDAwMC92ZWxrYS9u/b3QtZm91bmQtaW1h/Z2UtMTUzODM4NjQ3/ODdsdS5qcGc';
                }
              },
              icon: const Icon(
                  Icons.photo), // Change the icon as per your requirement
              color:
                  Colors.blue, // Change the icon color as per your requirement
              iconSize: 25, // Change the icon size as per your requirement
            ),
            // Add more TextField widgets as needed
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (docID == null) {
                fireStoreService.createNode(
                    textController.text, textController2.text, imageURL);
              } else {
                fireStoreService.updateNewNode(
                    docID, textController.text, textController2.text, imageURL);
              }
              textController.clear();
              textController2.clear();
              Navigator.pop(context);
            },
            child: const Text("ADD"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('News Updates', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(189, 104, 103, 103),
      ),
      backgroundColor: Colors.white, // Dark background color
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
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
                      color: const Color.fromARGB(
                          192, 119, 119, 119), // Darker color for the list tile
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        updateTextHeading,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                      // subtitle: Text(
                      //   updateTextDetails,
                      //   style: const TextStyle(
                      //     color: Colors.white, // Text color
                      //   ),
                      // ),
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
                          PopupMenuButton(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white, // Icon color
                            ),
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry>[
                              PopupMenuItem(
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.edit,
                                    color: Colors.black, // Icon color
                                  ),
                                  title: const Text('Edit'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    openNoteBox(docID: docID);
                                  },
                                ),
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.delete,
                                    color: Colors.black, // Icon color
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
                            child: Container(
                              width: 100, // Adjust the width as needed
                              height: 50, // Adjust the height as needed
                              color: Colors.grey, // Placeholder color
                              child: imageURL.isNotEmpty
                                  ? Image.network(
                                      imageURL,
                                      fit: BoxFit.fill,
                                    )
                                  : const Icon(
                                      Icons.add_photo_alternate,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
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
