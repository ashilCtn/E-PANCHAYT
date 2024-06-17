import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/my_button.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';

class ServicePage extends StatelessWidget {
  ServicePage({super.key});
  final TextEditingController searchTwo = TextEditingController();
  void landTaxCheck() {}
  void getComplaints() {}
  void getDevInfo() {}
  void getNerbyServ() {}
  void getCertificates() {}
  void getJobInfo() {}
  void searchFun() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.barAppNav,
        automaticallyImplyLeading: false, // Remove back button
        title: const Center(
          child: Text(
            "Services",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    controller: searchTwo,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      hintText: "Search",
                      prefixIcon: IconButton(
                          onPressed: searchFun, icon: const Icon(Icons.search)),
                    ),
                    obscureText: false,
                  ),
                ),
                const SizedBox(height: 10),
                MyButton(onTap: landTaxCheck, text: "Land Tax Check"),
                const SizedBox(height: 10),
                MyButton(onTap: getComplaints, text: "Complaints"),
                const SizedBox(height: 10),
                MyButton(onTap: getDevInfo, text: "Development Works"),
                const SizedBox(height: 10),
                MyButton(onTap: getNerbyServ, text: "Nearby Services"),
                const SizedBox(height: 10),
                MyButton(onTap: getCertificates, text: "Certificates"),
                const SizedBox(height: 10),
                MyButton(onTap: getJobInfo, text: "Jobs"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
