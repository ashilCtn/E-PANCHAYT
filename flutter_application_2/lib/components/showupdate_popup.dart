import 'package:flutter/material.dart';

Future<void> showCustomDialog(BuildContext context, String title,
    String subtitle, String imageURL) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // Pop the dialog when tapped outside
        },
        child: Container(
          color: const Color.fromARGB(87, 0, 0, 0),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Space between dialog top and image top
                    const SizedBox(height: 15),
                    // Image at the top (covering 1/4th of the pop-up)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20), // Adjusted padding
                      child: SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height *
                              0.2, // Adjusted height
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(imageURL),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding for separation
                    const SizedBox(height: 10),
                    // Text widgets displaying string variables
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding for separation
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
