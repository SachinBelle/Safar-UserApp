import 'package:flutter/material.dart';

const Color kTextFieldBackground = Color(0xFFF5F6FA);
const double kTextFieldBorderRadius = 8.0;

InputDecoration baseTextFieldDecoration({String? hintText}) {
  return InputDecoration(
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
      borderSide: BorderSide(
        color: Color(0xFFE5CE3B), // Primary color for focus
        width: 2,
      ),
    ),
    hintStyle: const TextStyle(
      color: Color(0xFFAEACAC), // Hint text color
    ),
  );
}
