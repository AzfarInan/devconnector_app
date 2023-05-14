import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.passwordField = false,
    this.obscurePassword = true,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) validator;
  final bool passwordField;
  final bool obscurePassword;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return passwordField
        ? TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        labelText: labelText,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white, // Change the color here
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.yellow,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.yellow, fontSize: 16),
        labelStyle: TextStyle(
          color: Colors.white,
          fontFamily: GoogleFonts.righteous().fontFamily,
          fontSize: 28,
        ),
        suffixIcon: suffixIcon,
      ),
      cursorColor: Colors.white,
      style: TextStyle(
        fontFamily: GoogleFonts.righteous().fontFamily,
        color: Colors.white70,
        fontSize: 25,
      ),
      obscuringCharacter: '*',
      obscureText: obscurePassword,
      keyboardType: TextInputType.emailAddress,
      validator: validator,
    )
        : TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        labelText: labelText,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white, // Change the color here
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.yellow,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.yellow, fontSize: 16),
        labelStyle: TextStyle(
          color: Colors.white,
          fontFamily: GoogleFonts.righteous().fontFamily,
          fontSize: 28,
        ),
      ),
      cursorColor: Colors.white,
      style: TextStyle(
        fontFamily: GoogleFonts.righteous().fontFamily,
        color: Colors.white70,
        fontSize: 25,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: validator,
    );
  }
}