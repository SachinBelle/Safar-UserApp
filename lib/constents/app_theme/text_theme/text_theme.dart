import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const Color kMainHeadlineColor = Color(0xFF1D3557);
const Color kSubMainHeadlineColor = Color(0xFF2C2C2C);
const Color kInstructionTextColor = Color(0xFF6C757D);
const Color kTextFieldHeadlineColor = Color(0xFF2C2C2C);
const Color kTextFieldHintColor = Color(0xFF6C757D);
const Color kOutlinedButtonTextColor = Color(0xFF1D3557);
const Color kFilledButtonTextColor = Color(0xFFFDFCFB);
const Color kNavbarButtonTextColour = Color(0xFF1D3557);

class AppTextStyles {
  static final mainHeadline = GoogleFonts.poppins(
    fontWeight: FontWeight.w500, 
    fontSize: 20,
    color: kMainHeadlineColor,
  );

  static final subMainHeadline = GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 16,
    color: kSubMainHeadlineColor,
  );

  static final instructionText = GoogleFonts.poppins(
    fontWeight: FontWeight.w400, 
    fontSize: 14,
    color: kInstructionTextColor,
  );

  static final textFieldHeadline = GoogleFonts.poppins(
    fontWeight: FontWeight.w400, 
    fontSize: 16,
    color: kTextFieldHeadlineColor,
  );

  static final textFieldHint = GoogleFonts.poppins(
    fontWeight: FontWeight.w300, 
    fontStyle: FontStyle.italic,
    fontSize: 14,
    color: kTextFieldHintColor,
  );

  static final outlinedButtonText = GoogleFonts.poppins(
    fontWeight: FontWeight.w500, 
    fontSize: 16,
    color: kOutlinedButtonTextColor,
  );

  static final filledButtonText = GoogleFonts.poppins(
    fontWeight: FontWeight.w500, 
    fontSize: 16,
    color: kFilledButtonTextColor,
  );

  static final navbarButtonText = GoogleFonts.poppins(
    fontWeight: FontWeight.w300, 
    fontSize: 14,
    color: kNavbarButtonTextColour,
  );
}
