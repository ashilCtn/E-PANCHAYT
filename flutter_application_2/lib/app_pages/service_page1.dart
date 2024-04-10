import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/my_button.dart';

class ServicePage extends StatelessWidget {
  ServicePage({super.key});
  final TextEditingController searchTwo = TextEditingController();
  void LandTaxCheck(){}
  void getComplaints(){}
  void getDevInfo(){}
  void getNerbyServ(){}
  void getCertificates(){}
  void getJobInfo(){}
  void searchFun(){}

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
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: searchTwo,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
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
                          onPressed: searchFun, 
                          icon:Icon(Icons.search)
                        ),
                      ),
                    obscureText: false,
                  ),
                ),
                SizedBox(height: 10),
                MyButton(onTap: LandTaxCheck, text:"Land Tax Check"),
                SizedBox(height: 10),
                MyButton(onTap: getComplaints, text: "Complaints"),
                SizedBox(height: 10),
                MyButton(onTap: getDevInfo, text: "Development Works"),
                SizedBox(height: 10),
                MyButton(onTap: getNerbyServ, text: "Nearby Services"),
                SizedBox(height: 10),
                MyButton(onTap: getCertificates, text: "Certificates"),
                SizedBox(height: 10),
                MyButton(onTap: getJobInfo, text: "Jobs"),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
