import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/More_Bar/Contacts_Page/addnewcontact_page.dart';
import 'package:flutter_application_2/app_pages/More_Bar/Contacts_Page/cached_profile_avatar.dart';
import 'package:flutter_application_2/app_pages/More_Bar/Contacts_Page/cc_classification.dart';
import 'package:flutter_application_2/core/RBAC/role_retrieve.dart';
import 'package:flutter_application_2/core/theme/theme.dart';
import 'package:flutter_application_2/services/firestore_contacts_crud.dart';
import 'package:flutter_application_2/services/firestore_register.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dropdown_search/dropdown_search.dart';

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
  String imageURL =
      'https://img.freepik.com/free-vector/404-error-with-landscape-concept-illustration_114360-7898.jpg';
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
        // print('#%#%%#%#%#%${role}');
      });
    }
  }

  Stream<QuerySnapshot> getContactsStream() {
    if (selectedType == 'All') {
      return fireStoreServiceContacts.readAllContacts();
    } else {
      return FirebaseFirestore.instance
          .collection('Contact_List')
          .where('Contact Type', isEqualTo: selectedType)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    final primaryGradient = LinearGradient(
      colors: [
        colorScheme.primary,
        colorScheme.secondary,
        colorScheme.tertiary,
      ],
    );

    // double itemHeight = 56.25;
    // double maxHeight = categories.length * itemHeight;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Contacts'.tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          maxLines: 2,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: .0),
                  child: DropdownSearch<String>(
                    popupProps: const PopupProps.menu(
                      constraints: BoxConstraints(maxHeight: 225),
                      showSelectedItems: true,
                      // disabledItemFn: (String s) => s.startsWith('I'),
                    ),
                    items: categories,
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "Contact Type",
                      ),
                    ),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedType = newValue;
                        });
                        // print('Selected: $newValue');
                      }
                    },
                    selectedItem: selectedType,
                  ),
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          gradient: primaryGradient,
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
                          leading: CachedProfileAvatar(
                            imageUrl: imageURL,
                          ),
                          title: Text(
                            fetchCName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode
                                  ? AppTheme.darkThemeMode.textTheme.bodyLarge
                                          ?.color ??
                                      Colors.black
                                  : AppTheme.lightThemeMode.textTheme.bodyLarge
                                          ?.color ??
                                      Colors.black,
                            ),
                          ),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${'Designation'.tr} : $fetchCDesignation',
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? AppTheme.darkThemeMode.textTheme
                                                    .bodyLarge?.color ??
                                                Colors
                                                    .black // Fallback to default color if null
                                            : AppTheme.lightThemeMode.textTheme
                                                    .bodyLarge?.color ??
                                                Colors.black,
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
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? AppTheme.darkThemeMode.textTheme
                                                  .bodyLarge?.color ??
                                              Colors
                                                  .black // Fallback to default color if null
                                          : AppTheme.lightThemeMode.textTheme
                                                  .bodyLarge?.color ??
                                              Colors.black,
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
                                      title: Text('Message'.tr),
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
                                      title: Text('Call'.tr),
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
                                        title: Text('Edit'.tr),
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
                                        title: Text('Remove'.tr),
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
                        // ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('No Added Contacts!!!'.tr),
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
