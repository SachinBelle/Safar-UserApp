import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safar/constants/app_theme/text_theme/text_theme.dart';
import 'package:safar/presentation/pages/get%20start%20page/getstart_page.dart';
import 'package:safar/presentation/pages/home%20screen/homescreen_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpVerificationPage extends StatefulWidget {
  final String userName;
  final String mobileNumber;
  final String countryCode;
  const OtpVerificationPage({
    super.key,
    required this.userName,
    required this.mobileNumber,
    required this.countryCode,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> with CodeAutoFill {
  final ValueNotifier<int> _resendTimerNotifier = ValueNotifier<int>(60);
  bool _isResendEnabled = false;
  final TextEditingController inputOtp = TextEditingController();
  Timer? _timer;

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();

    _sendOtp();

    // Start listening for SMS code automatically
    listenForCode();

    // Listen to changes in the input field, verify only when length == 6
    inputOtp.addListener(() {
      if (inputOtp.text.trim().length == 6) {
        _verifyOtp();
      }
    });
  }
   void setSharedPrefs()async{
      final prefs=await SharedPreferences.getInstance();
      prefs.setBool("isloggedIn", true);

     }

  // Override from CodeAutoFill mixin to receive the SMS code automatically
  @override
  void codeUpdated() {
    if (code != null) {
      setState(() {
        inputOtp.text = code!;
      });
      _verifyOtp();
    }
  }

  Future<void> _sendOtp() async {
    try {
      await supabase.auth.signInWithOtp(
        phone: "${widget.countryCode}${widget.mobileNumber}",
        channel: OtpChannel.sms,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              "OTP Sent Successfully!",
            ),
          ),
        ),
      );

      _startResendTimer();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              "Failed to send OTP: ${e.toString()}",
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
    }
  }

  void _startResendTimer() {
    _timer?.cancel();
    _resendTimerNotifier.value = 60;
    _isResendEnabled = false;
    setState(() {}); // Update resend button state immediately

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimerNotifier.value > 0) {
        _resendTimerNotifier.value--;
      } else {
        _isResendEnabled = true;
        timer.cancel();
        setState(() {}); // Update resend button state
      }
    });
  }

  Future<void> _verifyOtp() async {
    final otp = inputOtp.text.trim();
    if (otp.length != 6) {
      // Do not verify if OTP length is not 6
      return;
    }

    try {
      final response = await supabase.auth.verifyOTP(
        phone: "${widget.countryCode}${widget.mobileNumber}",
        token: otp,
        type: OtpType.sms,
      );
      print('OTP verification response: $response');

      final user = supabase.auth.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Verification failed',
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.white,
          ),
        );
        return;
      }
      setSharedPrefs();

      final userId = user.id; // UUID from Supabase Auth

      // Check if user exists in user_data
      final existingUser = await supabase
          .from('user_data')
          .select('user_linked_uid')
          .eq('user_uid', userId)
          .maybeSingle();


      if (existingUser == null) {
        // New user → insert into user_data
        await supabase.from('user_data').insert({
          'user_name': widget.userName,
          'phone_number': "${widget.countryCode}${widget.mobileNumber}",
          'user_uid': userId,
          'user_linked_uid': [], // start with empty list
        });

        // Save locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('phone_number', widget.mobileNumber);
        await prefs.setString('UserName', widget.userName);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Welcome! Account created.',
              style: TextStyle(color: Colors.green),
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.white,
          ),
        );

        // Navigate to UID creation page
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => GetStartPage()),
          );
        }
      } else {
        // Handle already registered user here
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(
              child: Text(
                'User already registered. Logging in...',
                style: TextStyle(color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.white,
          ),
        );
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomescreenPage()));
      
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Verification failed: ${e.toString()}",
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.white,
        ),
      );
    }
  }

  Future<void> _resendOtp() async {
    if (!_isResendEnabled) return;

    try {
      await supabase.auth.signInWithOtp(
        phone: "${widget.countryCode}${widget.mobileNumber}",
        channel: OtpChannel.sms,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              "OTP resent successfully",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ),
      );
      _startResendTimer();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              "Failed to resend OTP: ${e.toString()}",
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _resendTimerNotifier.dispose();
    SmsAutoFill().unregisterListener();
    inputOtp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Verify OTP", style: AppTextStyles.mainHeadline),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: "We’ve sent a 6-digit code to ",
                  style: AppTextStyles.instructionText,
                ),
                TextSpan(
                  text: "${widget.countryCode} ${widget.mobileNumber} ",
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: "\nPlease enter it below.",
                  style: AppTextStyles.instructionText,
                ),
              ]),
            ),
            const SizedBox(height: 15),
            Center(
              child: PinFieldAutoFill(
                controller: inputOtp,
                autoFocus: true,
                cursor: Cursor(
                  color: Colors.grey,
                  width: 2,
                  height: 20,
                  enabled: true,
                ),
                keyboardType: TextInputType.number,
                decoration: BoxLooseDecoration(
                  bgColorBuilder: FixedColorBuilder(const Color(0xfff5f6fa)),
                  gapSpace: 10,
                  strokeWidth: 1.5,
                  hintText: "------",
                  strokeColorBuilder: PinListenColorBuilder(
                    Colors.grey,
                    const Color.fromARGB(0, 158, 158, 158),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    height: 1.4,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                GestureDetector(
                  onTap: _isResendEnabled ? _resendOtp : null,
                  child: Text(
                    "Resend OTP",
                    style: _isResendEnabled
                        ? AppTextStyles.instructionText.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline,
                          )
                        : AppTextStyles.instructionText.copyWith(
                            color: Colors.grey,
                          ),
                  ),
                ),
                const SizedBox(width: 8),
                ValueListenableBuilder<int>(
                  valueListenable: _resendTimerNotifier,
                  builder: (context, timerValue, child) {
                    return Text(
                      _isResendEnabled ? "" : "(after $timerValue s)",
                      style: AppTextStyles.instructionText.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
