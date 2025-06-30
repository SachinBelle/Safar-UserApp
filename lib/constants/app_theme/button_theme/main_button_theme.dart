import 'package:flutter/material.dart';
import 'package:safar/constants/app_theme/text_theme/text_theme.dart';

const Color kButtonColor = Color(0xFF1D3557);
const Color kAddBusButtonColor = Color(0xFFF4A261);

//main button with filled colour
final ButtonStyle filledButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kButtonColor,
  foregroundColor: Colors.black, // Text color
  textStyle: AppTextStyles.filledButtonText,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  padding: const EdgeInsets.symmetric(
    vertical: 0,
    horizontal: 0,
  ), // We'll handle size in the widget
);

//main button with outlined colour
final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
  foregroundColor: kButtonColor, // Text color
  textStyle: AppTextStyles.outlinedButtonText,
  side: const BorderSide(color: kButtonColor, width: 2),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  padding: const EdgeInsets.symmetric(
    vertical: 0,
    horizontal: 0,
  ), // We'll handle size in the widget
);
