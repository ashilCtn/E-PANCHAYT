import 'package:flutter/material.dart';
// import 'package:flutter_application_2/components/loading.dart';
import 'package:flutter_application_2/components/update_page_textfield.dart';
import 'package:flutter_application_2/services/profile_firestore.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> relationControllers = [];
  List<TextEditingController> aadhaarControllers = [];
  final List<String> _expectednumbers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  String _selectedNumber = '1';

  final FireStoreServiceProfile _firestoreService = FireStoreServiceProfile();
  List<FamilyMember> familyMembers = [];

  List<Widget> _buildFamilyMemberContainers(int count) {
    nameControllers.clear();
    relationControllers.clear();
    aadhaarControllers.clear();

    List<Widget> containers = [];
    for (int i = 0; i < count; i++) {
      TextEditingController nameController = TextEditingController();
      TextEditingController relationController = TextEditingController();
      TextEditingController aadhaarController = TextEditingController();

      nameControllers.add(nameController);
      relationControllers.add(relationController);
      aadhaarControllers.add(aadhaarController);

      containers.add(
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Family Member ${i + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: UpdatePageTextField(
                  controller: nameController,
                  hintText: 'Name',
                ),
              ),
              ListTile(
                title: UpdatePageTextField(
                  controller: relationController,
                  hintText: 'Relation with User',
                ),
              ),
              ListTile(
                title: UpdatePageTextField(
                  controller: aadhaarController,
                  hintText: 'Aadhaar',
                ),
              ),
            ],
          ),
        ),
      );
    }
    return containers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pushNamed(context, 'profile');
            Navigator.pop(context);
          },
        ),
        title: const Text('Update Profile'),
        actions: [
          IconButton(
            onPressed: () {
              //upload to firestore
              // Loader.showLoadingDialog(context);
              saveToFirebase();
              // Navigator.of(context).pop();
              Navigator.pop(context);
              // Navigator.pop(context);
              // Navigator.pushNamed(context, 'profile');
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
              ListTile(
                title: const Text(
                  'Family Count',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: DropdownButton<String>(
                  value: _selectedNumber,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedNumber = newValue!;
                    });
                  },
                  items: _expectednumbers
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              ..._buildFamilyMemberContainers(int.parse(_selectedNumber)),
            ],
          ),
        ),
      ),
    );
  }

  void saveToFirebase() {
    familyMembers.clear(); // Clear existing family members
    for (int i = 0; i < int.parse(_selectedNumber); i++) {
      familyMembers.add(
        FamilyMember(
          name: nameControllers[i].text,
          relationwithuser: relationControllers[i].text,
          aadhaar: aadhaarControllers[i].text,
        ),
      );
    }
    _firestoreService.saveToFirebase(familyMembers);
  }
}
