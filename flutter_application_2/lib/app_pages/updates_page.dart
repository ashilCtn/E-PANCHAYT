// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_2/services/firestore.dart';

// class UpdatesPage extends StatefulWidget {
//   const UpdatesPage({super.key});

//   @override
//   State<UpdatesPage> createState() => _UpdatesPageState();
// }

// class _UpdatesPageState extends State<UpdatesPage> {
//   //firestore
//   final FireStoreService fireStoreService = FireStoreService();
//   //textcontroller
//   final TextEditingController textController = TextEditingController();

//   //open a dialog box to add a new update
//   void openNoteBox({String? docID}) {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               content: TextField(
//                 controller: textController,
//               ),
//               actions: [
//                 //botton to save the update string
//                 ElevatedButton(
//                   onPressed: () {
//                     //add a new node
//                     if (docID == null) {
//                       fireStoreService.createNode(textController.text);
//                     }
//                     //else update an existing node
//                     else {
//                       fireStoreService.updateNewNode(
//                           docID, textController.text);
//                     }

//                     //clear the text controller
//                     textController.clear();

//                     //close the box
//                     Navigator.pop(context);
//                   },
//                   child: const Text("ADD"),
//                 )
//               ],
//             ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Updates')),
//       floatingActionButton: FloatingActionButton(
//         onPressed: openNoteBox,
//         child: const Icon(Icons.add),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: fireStoreService.readNode(),
//         builder: (context, snapshot) {
//           //if we have details, the get all docs
//           if (snapshot.hasData) {
//             List updatesList = snapshot.data!.docs;

//             //display as a list
//             return ListView.builder(
//                 itemCount: updatesList.length,
//                 itemBuilder: (context, index) {
//                   //get each individual doc
//                   DocumentSnapshot document = updatesList[index];
//                   String docID = document.id;

//                   //get node from each doc
//                   Map<String, dynamic> data =
//                       document.data() as Map<String, dynamic>;
//                   String updateText = data['News Update'];

//                   //display as a tile
//                   return ListTile(
//                       title: Text(updateText),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             onPressed: () => openNoteBox(docID: docID),
//                             icon: const Icon(Icons.settings),
//                           ),
//                           //delete button
//                           IconButton(
//                               onPressed: () =>
//                                   fireStoreService.deleteNode(docID),
//                               icon: const Icon(Icons.delete)),
//                         ],
//                       ));
//                 });
//           }
//           //if there is no data returned
//           else {
//             return const Text("No New Updates...");
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/firestore.dart';

class UpdatesPage extends StatefulWidget {
  const UpdatesPage({super.key});

  @override
  State<UpdatesPage> createState() => _UpdatesPageState();
}

class _UpdatesPageState extends State<UpdatesPage> {
  final FireStoreService fireStoreService = FireStoreService();
  final TextEditingController textController = TextEditingController();

  void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (docID == null) {
                fireStoreService.createNode(textController.text);
              } else {
                fireStoreService.updateNewNode(docID, textController.text);
              }
              textController.clear();
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
                String updateText = data['News Update'];

                return Container(
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
                      updateText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => openNoteBox(docID: docID),
                          icon: const Icon(Icons.settings),
                          color: Colors.white, // Icon color
                        ),
                        IconButton(
                          onPressed: () => fireStoreService.deleteNode(docID),
                          icon: const Icon(Icons.delete),
                          color: Colors.white, // Icon color
                        ),
                      ],
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
