import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/More_Bar/Contacts_Page/addnewcontact_page.dart';
import 'package:flutter_application_2/app_pages/More_Bar/Contacts_Page/cc_classification.dart';
import 'package:flutter_application_2/components/profile_avatar.dart';
import 'package:flutter_application_2/core/RBAC/role_retrieve.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';
import 'package:flutter_application_2/services/firestore_contacts_crud.dart';
import 'package:flutter_application_2/services/firestore_register.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final FireStoreServiceContacts fireStoreServiceContacts =
      FireStoreServiceContacts();
  final TextEditingController cName = TextEditingController();
  final TextEditingController cDesignation = TextEditingController();
  final TextEditingController cNumber = TextEditingController();
  String imageURL = '';
  /////////////////////////////////////////////////////////////////////
  //Role Retrieved
  String role = '';
  FireStoreRegister fireStoreRegister = FireStoreRegister();
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    super.initState();
    getUserRole();
    loadCategories();
  }

  String selectedType = 'All';
  List<String> categories = ['All'];

  Future<void> loadCategories() async {
    CcClassification ccClassification = CcClassification();
    List<String> retrievedCategories = await ccClassification.readTypes();
    if (mounted) {
      setState(() {
        categories = [...retrievedCategories];
      });
    }
  }

  Future<void> getUserRole() async {
    AccessRole accessRole = AccessRole();
    String retrievedRole = await accessRole.getUserRole();
    if (mounted) {
      setState(() {
        role = retrievedRole;
        print('#%#%%#%#%#%${role}');
      });
    }
  }

  Stream<QuerySnapshot> getContactsStream() {
    if (selectedType == 'All') {
      return fireStoreServiceContacts.readAllContacts();
    } else {
      print(FirebaseFirestore.instance
          .collection('Contact_List')
          .where('Contact Type', isEqualTo: selectedType)
          .snapshots());
      return FirebaseFirestore.instance
          .collection('Contact_List')
          .where('Contact Type', isEqualTo: selectedType)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.barAppNav,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Contacts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (role == 'admin' || role == 'superuser')
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'addNewContact');
                },
                icon: const Icon(CupertinoIcons.person_badge_plus)),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter options
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: selectedType, // Selected value
                  items: categories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedType = newValue;
                      });
                      print('Selected: $newValue');
                    }
                  },
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
            indent: 8,
            endIndent: 8,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getContactsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List contactList = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: contactList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = contactList[index];
                      String docID = document.id;
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String fetchCName = data['Contact Name'];
                      String fetchCDesignation = data['Contact Designation'];
                      String fetchCNumber = data['Contact Number'];
                      String imageURL = data['Profile Pic'];

                      return Container(
                        margin: const EdgeInsets.all(8),
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
                          contentPadding: const EdgeInsets.all(0),
                          leading: ProfileAvatar(
                            imageUrl: imageURL,
                          ),
                          title: Text(
                            fetchCName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Designation : $fetchCDesignation',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      maxLines: null,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Row(
                                children: [
                                  Text(
                                    fetchCNumber,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PopupMenuButton(
                                icon: const Icon(
                                  Icons.more_vert,
                                ),
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry>[
                                  PopupMenuItem(
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.chat,
                                      ),
                                      title: const Text('Message'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        final Uri url = Uri.parse(
                                            "https://wa.me/+91$fetchCNumber/");
                                        launchUrl(url);
                                      },
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.call,
                                      ),
                                      title: const Text('Call'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        final Uri url =
                                            Uri.parse("tel:+91$fetchCNumber");
                                        launchUrl(url);
                                      },
                                    ),
                                  ),
                                  if (role == 'admin' || role == 'superuser')
                                    PopupMenuItem(
                                      child: ListTile(
                                        leading: const Icon(
                                          Icons.edit,
                                        ),
                                        title: const Text('Edit'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddNewContactPage(
                                                      docID: docID),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  if (role == 'admin' || role == 'superuser')
                                    PopupMenuItem(
                                      child: ListTile(
                                        leading: const Icon(
                                          CupertinoIcons.person_badge_minus,
                                        ),
                                        title: const Text('Remove'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          fireStoreServiceContacts
                                              .deleteContact(docID);
                                        },
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No Added Contacts!!!'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
