import 'package:flutter/material.dart';

class CustomForms extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool? obscure;

  const CustomForms(
      {super.key, required this.controller, required this.hint, this.obscure});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xffBDBDBD),
            fontSize: 14,
          ),
          isDense: true,
          filled: true,
          fillColor: const Color(0xffF6F6F6),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color(0xffC8C8C8).withOpacity(0.5),
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color(0xffC8C8C8).withOpacity(0.5),
              width: 1.0,
            ),
          ),
        ),
        obscureText: obscure ?? false,
      ),
    );
  }
}
