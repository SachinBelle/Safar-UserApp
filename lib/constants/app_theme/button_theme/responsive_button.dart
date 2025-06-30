import 'package:flutter/material.dart';
import 'package:safar/constants/app_theme/button_theme/main_button_theme.dart';
// import 'button_theme.dart';

class ResponsiveButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool outlined;

  const ResponsiveButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    // Reference size: 345x45 (design size)
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // You can adjust these ratios as needed for your design
    final buttonWidth = screenWidth * 0.9; // 90% of screen width
    final buttonHeight = screenHeight * 0.06; // 6% of screen height

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: outlined
          ? OutlinedButton(
              style: outlinedButtonStyle,
              onPressed: onPressed,
              child: Text(text, style: const TextStyle(fontSize: 16)),
            )
          : ElevatedButton(
              style: filledButtonStyle,
              onPressed: onPressed,
              child: Text(text, style: const TextStyle(fontSize: 16)),
            ),
    );
  }
}
