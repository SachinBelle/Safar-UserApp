import 'package:flutter/material.dart';
import 'package:safar/constants/app_theme/text_theme/text_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safar/constants/app_theme/button_theme/responsive_button.dart';
import 'package:safar/presentation/pages/home screen/homescreen_page.dart';

class GetStartPage extends StatefulWidget {
  const GetStartPage({super.key});

  @override
  State<GetStartPage> createState() => _GetStartPageState();
}

class _GetStartPageState extends State<GetStartPage> {
  bool _isChecked = false;

  void _handleGetStarted() {
    if (_isChecked) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomescreenPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('Accept terms and Conditions and Privacy Policy to Continue',style: AppTextStyles.instructionText,)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsiveness
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),

              // Title
              Text(
                'All Set to Track Route!',
                style: AppTextStyles.mainHeadline,
              ),

              SizedBox(height: size.height * 0.01),

              // Subtitle
              Text(
                'You\'re ready to start tracking your child\'s bus! \nLets make safar safe, Let\'s Go!',
                style: AppTextStyles.instructionText,
              ),

              // Center image
              Expanded(
                child: Center(
                  child: SvgPicture.asset(
                    'assets/map_img_gsp.svg', // Make sure to add this image to your assets
                    width: size.width * 0.5,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Terms and Privacy Policy
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 45,
                    child: Checkbox(
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.instructionText,
                        children: [
                          const TextSpan(
                            text: 'By continuing, you agree to Safar\'s ',
                          ),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: AppTextStyles.instructionText.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: AppTextStyles.instructionText.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.02),

              // Get Started Button
              Center(
                child: ResponsiveButton(
                  text: 'Get Started',
                  outlined: !_isChecked,
                  onPressed: _handleGetStarted,
                ),
              ),

              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
