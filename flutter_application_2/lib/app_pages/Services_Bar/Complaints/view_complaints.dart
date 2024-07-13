import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/Services_Bar/Complaints/firebase_service.dart';
import 'package:flutter_application_2/components/my_button.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';
import 'package:flutter_application_2/core/theme/theme.dart';

class CreateORViewComplaints extends StatefulWidget {
  const CreateORViewComplaints({super.key});

  @override
  State<CreateORViewComplaints> createState() => _CreateORViewComplaintsState();
}

Map<String, Map<String, dynamic>> result = {};

RealTimeFirebase realTimeFirebase = RealTimeFirebase();

Future<void> getPublicComplaints() async {
  result = await realTimeFirebase.realTimeRead(cType: 'Public');
  print(result);
}

class _CreateORViewComplaintsState extends State<CreateORViewComplaints> {
  RealTimeFirebase realTimeFirebase = RealTimeFirebase();
  final String cType = 'Public';
  Map<String, bool> hasIncrementedMap =
      {}; // Persistent state for each complaint

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
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MyButton(
              onTap: () {
                Navigator.pushNamed(context, 'cplt_reg');
              },
              text: '                  Create\n Suggestions or Complaints',
            ),
          ),
          const SizedBox(height: 8),
          const Divider(
            height: 1,
            thickness: 0.5,
            indent: 8,
            endIndent: 8,
          ),
          const SizedBox(height: 1),
          const Card(
            child: ListTile(
              title: Text(
                'Public Complaints',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 1),
          const Divider(
            height: 1,
            thickness: 0.5,
            indent: 8,
            endIndent: 8,
          ),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: _listItem(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listItem() {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return StreamBuilder<Map<String, Map<String, dynamic>>>(
      stream: realTimeFirebase.realTimeRead(cType: 'Public').asStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No complaints found !!!'));
        } else {
          final complaints = snapshot.data!;
          return ListView.builder(
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final complaint = complaints.entries.elementAt(index);
              final complaintData = complaint.value;
              final complaintKey = complaint.key;
              final hasIncremented = hasIncrementedMap[complaintKey] ?? false;
              print(complaintData);

              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          complaintData['subject'] ?? 'No Title',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Divider(
                        height: 2,
                        thickness: 0.5,
                        indent: 8,
                        endIndent: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                complaintData['Image_URL'] ??
                                    'https://via.placeholder.com/150',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Wrap(
                              children: [
                                Text(
                                  complaintData['Complaint_Explained'] ??
                                      'No Description',
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (!hasIncremented) {
                              int temp = int.tryParse(
                                      complaintData['support'] ?? '0') ??
                                  0;
                              temp++;
                              complaintData['support'] = temp.toString();
                              realTimeFirebase.updateSupportCount(
                                complaintId: complaintKey,
                                newSupportCount: temp.toString(),
                              );
                            } else {
                              int temp = int.tryParse(
                                      complaintData['support'] ?? '0') ??
                                  0;
                              temp--;
                              complaintData['support'] = temp.toString();
                              realTimeFirebase.updateSupportCount(
                                complaintId: complaintKey,
                                newSupportCount: temp.toString(),
                              );
                            }
                            hasIncrementedMap[complaintKey] = !hasIncremented;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 11),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  shape: BoxShape.rectangle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: isDarkMode
                                          ? AppPallete.lightOverlay
                                          : AppPallete.overlay,
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 13.0, vertical: 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      complaintData['support'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.thumb_up_alt_outlined),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Support',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
