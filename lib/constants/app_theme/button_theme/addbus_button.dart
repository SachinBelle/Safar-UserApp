import 'package:flutter/material.dart';
import 'package:safar/constants/app_theme/text_theme/text_theme.dart';
import 'main_button_theme.dart'; // For the color constant

class AddBusButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const AddBusButton({super.key, required this.onPressed, this.text = "Add Bus"});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 135,
      height: 35,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kAddBusButtonColor,
          textStyle: AppTextStyles.filledButtonText,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
