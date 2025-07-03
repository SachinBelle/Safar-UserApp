import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safar/constants/app_theme/button_theme/main_button_theme.dart';
// import 'button_theme.dart';

class ResponsiveButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool outlined;
  final double? height;

  const ResponsiveButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.outlined = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Reference size: 345x45 (design size)
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    // You can adjust these ratios as needed for your design
    final buttonWidth = double.infinity; // 90% of screen width
    final buttonHeight = height ?? 45.0; // Use provided height or default to 45

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: outlined
          ? OutlinedButton(
              style: outlinedButtonStyle(context),
              onPressed: onPressed,
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ElevatedButton(
              style: filledButtonStyle(context),
              onPressed: onPressed,
              child: Text(text, style: const TextStyle(fontSize: 16)),
            ),
    );
  }
}
