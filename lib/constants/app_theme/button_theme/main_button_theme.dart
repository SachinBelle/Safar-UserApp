import 'package:flutter/material.dart';
import 'package:safar/constants/app_theme/text_theme/text_theme.dart';

const Color kButtonColor = Color(0xFF1D3557);
const Color kAddBusButtonColor = Color(0xFFF4A261);

// Reference design size
const double kDesignButtonWidth = 343.0;
const double kDesignButtonHeight = 45.0;

//main button with filled colour
ButtonStyle filledButtonStyle(BuildContext context) {
  // Get the screen size for responsiveness
  final screenWidth = MediaQuery.of(context).size.width;

  // Calculate responsive width (90% of screen width, max 343)
  final buttonWidth = screenWidth * 0.9 > kDesignButtonWidth
      ? kDesignButtonWidth
      : screenWidth * 0.9;

  return ElevatedButton.styleFrom(
    backgroundColor: kButtonColor,
    foregroundColor: Colors.white, // Text color
    textStyle: AppTextStyles.filledButtonText,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    minimumSize: Size(buttonWidth, kDesignButtonHeight),
    maximumSize: Size(kDesignButtonWidth, kDesignButtonHeight),
    fixedSize: Size(buttonWidth, kDesignButtonHeight),
    padding: EdgeInsets.zero,
  );
}

//main button with outlined colour
ButtonStyle outlinedButtonStyle(BuildContext context) {
  // Get the screen size for responsiveness
  final screenWidth = MediaQuery.of(context).size.width;

  // Calculate responsive width (90% of screen width, max 343)
  final buttonWidth = screenWidth * 0.9 > kDesignButtonWidth
      ? kDesignButtonWidth
      : screenWidth * 0.9;

  return OutlinedButton.styleFrom(
    foregroundColor: kButtonColor, // Text color
    textStyle: AppTextStyles.outlinedButtonText,
    side: const BorderSide(color: kButtonColor, width: 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    minimumSize: Size(buttonWidth, kDesignButtonHeight),
    maximumSize: Size(kDesignButtonWidth, kDesignButtonHeight),
    fixedSize: Size(buttonWidth, kDesignButtonHeight),
    padding: EdgeInsets.zero,
  );
}
