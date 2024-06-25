import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    required this.hint,
    this.onChanged,
    this.obscureText = false,
    this.borderColor = Colors.black, this.maxLines, this.maxLength,
  });

  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String hint;
  final int? maxLines;
  final int? maxLength;
  final Color borderColor;
  final bool obscureText;
  final ValueChanged<String>?
      onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hint,
      ),
    );
  }
}
