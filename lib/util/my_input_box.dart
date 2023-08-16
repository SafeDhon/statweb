import 'package:flutter/material.dart';

class MyInputBox extends StatelessWidget {

  final Function(String) onChanged;
  final dynamic controller;
  final String hintText;
  final bool obscureText;

  const MyInputBox({
    super.key,
    required this.onChanged,
    this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)
          ),
          fillColor: Colors.grey.shade400,
          filled: true,
          hintText: hintText,
        ),
      ), 
    
    );
  }
}