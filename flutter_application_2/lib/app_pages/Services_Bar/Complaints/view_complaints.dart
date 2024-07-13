import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/Services_Bar/Complaints/firebase_service.dart';
import 'package:flutter_application_2/components/my_button.dart';
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
          const SizedBox(height: 4),
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
          const SizedBox(height: 4),
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
              return Container(
                // color: isDarkMode ? Colors.grey[800] : Colors.white,
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
                child: ListTile(
                  title: Text(
                    complaintData['title'] ?? 'No Title',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    complaintData['description'] ?? 'No Description',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
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
