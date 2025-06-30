import 'package:flutter/material.dart';
import 'package:safar/constants/app_theme/textfield_theme/textfield_theme.dart';

class NameTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;

  const NameTextField({super.key, this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.of(context).size.width * 0.9; // ~345 on 375px width
    return SizedBox(
      width: width,
      height: 45,
      child: TextField(
        controller: controller,
        decoration: baseTextFieldDecoration(hintText: hintText),
      ),
    );
  }
}

class PhoneTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;

  const PhoneTextField({super.key, this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.of(context).size.width * 0.58; // ~225 on 375px width
    return SizedBox(
      width: width,
      height: 45,
      child: TextField(
        controller: controller,
        decoration: baseTextFieldDecoration(hintText: hintText),
        keyboardType: TextInputType.phone,
      ),
    );
  }
}

class CountryCodeSelector extends StatelessWidget {
  final VoidCallback? onTap;
  final String code;

  const CountryCodeSelector({super.key, required this.code, this.onTap});

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.of(context).size.width * 0.29; // ~110 on 375px width
    return SizedBox(
      width: width,
      height: 45,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kTextFieldBackground,
            borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
          ),
          child: Text(
            code,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class OtpInputBox extends StatelessWidget {
  final TextEditingController? controller;

  const OtpInputBox({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        decoration: baseTextFieldDecoration(),
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
