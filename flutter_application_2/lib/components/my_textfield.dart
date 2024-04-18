// import 'package:flutter/material.dart';

// class MyTextField extends StatelessWidget {
//   final controller;
//   final String hintText;
//   final bool obscureText;
//   const MyTextField(
//       {super.key,
//       required this.controller,
//       required this.hintText,
//       required this.obscureText});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//             enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.white),
//                 borderRadius: BorderRadius.circular(12)),
//             focusedBorder: const OutlineInputBorder(
//               borderSide: BorderSide(color: Color.fromARGB(106, 247, 0, 255)),
//               borderRadius: BorderRadius.circular(12)
//             ),
//             fillColor: Colors.grey.shade200,
//             filled: true,
//             hintText: hintText,
//             hintStyle: TextStyle(color: Colors.grey[500])),
//         obscureText: obscureText,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0x9A008A2A)),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x9A008A2A)),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
        obscureText: obscureText,
      ),
    );
  }
}
