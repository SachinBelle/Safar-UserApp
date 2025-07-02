import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kTextFieldBackground = Color(0xFFF5F6FA);
const double kTextFieldBorderRadius = 8.0;

InputDecoration baseTextFieldDecoration({String? hintText}) {
  return InputDecoration(
    counterText: "",
    filled: true,
    fillColor: kTextFieldBackground,
    hintText: hintText,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
      borderSide: BorderSide.none
    ),
    hintStyle: GoogleFonts.poppins(
      fontStyle: FontStyle.italic,
      fontSize: 12,
    
      color: Color(0xff6c757d), // Hint text color
    ),
  );
}
