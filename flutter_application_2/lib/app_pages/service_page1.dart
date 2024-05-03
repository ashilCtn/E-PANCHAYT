import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/my_button.dart';

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
      /*appBar: AppBar(
        title: Text("Service Page",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text("Services"),
      ),*/
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: searchTwo,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey[500]),
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
