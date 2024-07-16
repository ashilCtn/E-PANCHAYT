import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/showupdate_popup.dart';
import 'package:flutter_application_2/core/RBAC/role_retrieve.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';
import 'package:flutter_application_2/core/theme/theme.dart';
import 'package:flutter_application_2/services/firestore.dart';
import 'package:flutter_application_2/services/firestore_register.dart';
import 'package:flutter/services.dart';

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
  String imageURL =
      'https://img.freepik.com/free-vector/404-error-with-landscape-concept-illustration_114360-7898.jpg';

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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Are you sure?"),
              content: const Text("Do you want to go back?"),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("NO"),
                ),
                ElevatedButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text("YES"),
                ),
              ],
            );
          },
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'News & Events',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor:
              isDarkMode ? AppPallete.barAppNav : AppPallete.lightBarAppNav,
          automaticallyImplyLeading: false,
          actions: [
            if (role == 'admin' || role == 'superuser')
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
                      showCustomDialog(context, updateTextHeading,
                          updateTextDetails, imageURL);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        gradient: isDarkMode
                            ? AppTheme.darkThemeGradient
                            : AppTheme.lightThemeGradient,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      updateTextHeading,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: isDarkMode
                                            ? AppTheme.darkThemeMode.textTheme
                                                    .headlineMedium?.color ??
                                                Colors.black
                                            : AppTheme.lightThemeMode.textTheme
                                                    .headlineMedium?.color ??
                                                Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl: imageURL,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          updateTextDetails,
                                          maxLines: 6,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (role == 'admin' || role == 'superuser')
                              PopupMenuButton(
                                icon: const Icon(
                                  Icons.more_vert,
                                ),
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry>[
                                  PopupMenuItem(
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.edit,
                                      ),
                                      title: const Text('Edit'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        fireStoreService.deleteNode(docID);
                                        Navigator.pushNamed(
                                            context, 'addNewUpdate');
                                      },
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.delete,
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
                            const SizedBox(width: 8),
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
      ),
    );
  }
}
