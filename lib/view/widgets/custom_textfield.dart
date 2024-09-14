import 'package:flutter/material.dart';
class CustomTextfield extends StatelessWidget {
  const CustomTextfield({super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.icon,
    //required this.textInputType
  });
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconData icon;
  //final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: textEditingController,
        obscureText: isPass,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 18
          ),
          prefixIcon: Icon(icon, color: Colors.black45,),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: InputBorder.none,
          filled: true,
          fillColor: const Color(0xFFedf0f8),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Colors.blue
            ),
            borderRadius: BorderRadius.circular(30)
          ),
        ),
      ),
    );
  }
}
