import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/Services_Bar/Complaints/firebase_service.dart';
import 'package:flutter_application_2/components/my_button.dart';
import 'package:flutter_application_2/components/showupdate_popup.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';
import 'package:flutter_application_2/core/theme/theme.dart';

class CreateORViewComplaints extends StatefulWidget {
  const CreateORViewComplaints({super.key});

  @override
  State<CreateORViewComplaints> createState() => _CreateORViewComplaintsState();
}

class _CreateORViewComplaintsState extends State<CreateORViewComplaints> {
  RealTimeFirebase realTimeFirebase = RealTimeFirebase();
  final String? userEmail = FirebaseAuth.instance.currentUser?.email;

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
              final complaintKey = complaint.key;
              final complaintData = complaint.value;

              return ComplaintItem(
                complaintKey: complaintKey,
                complaintData: complaintData,
                realTimeFirebase: realTimeFirebase,
                emailId: userEmail ?? '', // Pass the email ID here
              );
            },
          );
        }
      },
    );
  }
}

class ComplaintItem extends StatefulWidget {
  final String complaintKey;
  final Map<String, dynamic> complaintData;
  final RealTimeFirebase realTimeFirebase;
  final String emailId;

  const ComplaintItem({
    required this.complaintKey,
    required this.complaintData,
    required this.realTimeFirebase,
    required this.emailId,
    super.key,
  });

  @override
  _ComplaintItemState createState() => _ComplaintItemState();
}

class _ComplaintItemState extends State<ComplaintItem> {
  late bool hasIncremented;
  late List<dynamic> likes;

  @override
  void initState() {
    super.initState();
    // Initialize the likes list if it is null and make it mutable
    likes = List.from(widget.complaintData['likes'] ?? []);
    hasIncremented = likes.contains(widget.emailId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                widget.complaintData['subject'] ?? 'No Title',
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
            GestureDetector(
              onTap: () {
                showCustomDialog(
                    context,
                    widget.complaintData['subject'],
                    widget.complaintData['Complaint_Explained'],
                    widget.complaintData['Image_URL']);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.complaintData['Image_URL'] ??
                            "https://via.placeholder.com/150",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Wrap(
                      children: [
                        Text(
                          widget.complaintData['Complaint_Explained'] ??
                              'No Description',
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (!hasIncremented) {
                    widget.complaintData['support'] =
                        (int.parse(widget.complaintData['support']) + 1)
                            .toString();
                    likes.add(widget.emailId);
                  } else {
                    widget.complaintData['support'] =
                        (int.parse(widget.complaintData['support']) - 1)
                            .toString();
                    likes.remove(widget.emailId);
                  }
                  widget.complaintData['likes'] = likes;
                  widget.realTimeFirebase.updateSupportCount(
                    complaintId: widget.complaintKey,
                    emailId: widget.emailId,
                    isLiked: !hasIncremented,
                  );
                  hasIncremented = !hasIncremented;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 11),
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
                            widget.complaintData['support'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          hasIncremented
                              ? const Icon(Icons.thumb_up_alt_rounded)
                              : const Icon(Icons.thumb_up_alt_outlined),
                          const SizedBox(width: 8),
                          const Text(
                            'Support',
                            style: TextStyle(fontWeight: FontWeight.bold),
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
  }
}
