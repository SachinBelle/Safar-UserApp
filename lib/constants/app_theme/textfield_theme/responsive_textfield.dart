import 'package:country_code_picker/country_code_picker.dart';
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
    return Container(
       decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color(0xfff5f6fa)
      ),
      width: width,
      height: 50,
      child: TextField(
        textCapitalization: TextCapitalization.words,
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
       double.infinity; // ~225 on 375px width
    return Container(
      width: width,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color(0xfff5f6fa)
      ),
      child: TextField(
        maxLength: 10,
        
        controller: controller,
        decoration: baseTextFieldDecoration(hintText: hintText),
        keyboardType: TextInputType.phone,
      ),
    );
  }
}

class CountryCodeSelector extends StatefulWidget {
   final void Function(String)? onCodeChanged;


  const CountryCodeSelector({super.key, this.onCodeChanged, });

  @override
  State<CountryCodeSelector> createState() => _CountryCodeSelectorState();
}

class _CountryCodeSelectorState extends State<CountryCodeSelector> {
    final GlobalKey<CountryCodePickerState> _countryKey = GlobalKey();
      String selectedCode = "+91";
       void _showCountryPickerDialog() {
    _countryKey.currentState?.showCountryCodePickerDialog();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.3; // slightly larger
    return Container(
      width: width,
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kTextFieldBackground,
        borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        
        children: [
           CountryCodePicker(
        
            flagWidth: 20,
            flagDecoration:BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ) ,
            
            padding: EdgeInsetsGeometry.zero,
          key: _countryKey,
          onChanged: (value) {
           final code = value.dialCode ?? "+91";
  setState(() {
    selectedCode = code;
  });
  widget.onCodeChanged?.call(code);
          },
          initialSelection: 'IN',
          favorite: ['+91', 'IN'],
          showFlag: true,
          showDropDownButton: false, // Hide built-in drop down
          showCountryOnly: false,
          showOnlyCountryWhenClosed: false,
          alignLeft: false,
        ),
        GestureDetector(
          onTap: _showCountryPickerDialog,
          child: const Icon(
            Icons.arrow_drop_down,
            size: 20,
            color: Colors.grey,
          ),
        ),
         
        ],
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
