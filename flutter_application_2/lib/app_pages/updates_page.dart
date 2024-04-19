import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/firestore.dart';

class UpdatesPage extends StatefulWidget {
  const UpdatesPage({super.key});

  @override
  State<UpdatesPage> createState() => _UpdatesPageState();
}

class _UpdatesPageState extends State<UpdatesPage> {
  //firestore
  final FireStoreService fireStoreService = FireStoreService();
  //textcontroller
  final TextEditingController textController = TextEditingController();

  //open a dialog box to add a new update
  void openNoteBox({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                //botton to save the update string
                ElevatedButton(
                  onPressed: () {
                    //add a new node
                    if (docID == null) {
                      fireStoreService.createNode(textController.text);
                    }
                    //else update an existing node
                    else {
                      fireStoreService.updateNewNode(
                          docID, textController.text);
                    }

                    //clear the text controller
                    textController.clear();

                    //close the box
                    Navigator.pop(context);
                  },
                  child: const Text("ADD"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Updates')),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.readNode(),
        builder: (context, snapshot) {
          //if we have details, the get all docs
          if (snapshot.hasData) {
            List updatesList = snapshot.data!.docs;

            //display as a list
            return ListView.builder(
                itemCount: updatesList.length,
                itemBuilder: (context, index) {
                  //get each individual doc
                  DocumentSnapshot document = updatesList[index];
                  String docID = document.id;

                  //get node from each doc
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String updateText = data['News Update'];

                  //display as a tile
                  return ListTile(
                      title: Text(updateText),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => openNoteBox(docID: docID),
                            icon: const Icon(Icons.settings),
                          ),
                          //delete button
                          IconButton(
                              onPressed: () =>
                                  fireStoreService.deleteNode(docID),
                              icon: const Icon(Icons.delete)),
                        ],
                      ));
                });
          }
          //if there is no data returned
          else {
            return const Text("No New Updates...");
          }
        },
      ),
    );
  }
}
