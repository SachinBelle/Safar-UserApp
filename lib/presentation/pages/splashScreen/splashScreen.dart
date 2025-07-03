// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safar/presentation/pages/home%20screen/homescreen_page.dart';
import 'package:safar/presentation/pages/loginPages/CredentialPage.dart';
import 'package:safar/presentation/pages/walkthroughScreens/WalkThroughScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  // Add this flag
 

  bool? isWalkThroughVisted;
  bool? isLoggedIn;

  void loadPrefsAndNavigate() async {
   
    final prefs = await SharedPreferences.getInstance();
    isWalkThroughVisted = prefs.getBool("walkThroughVisted") ?? false;
    isLoggedIn = prefs.getBool("isloggedIn") ?? false;

    // Step 1: Run animations
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _onTransition1 = true;
    });

    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
      _onTransition2 = true;
    });

    // Optional: Add 200-500ms pause after animation
    await Future.delayed(const Duration(milliseconds: 500));

    // Step 2: Navigate
    if (!isWalkThroughVisted!) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Walkthroughscreen()),
      );
    } else if (!isLoggedIn!) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CredentialPage()),
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomescreenPage()),
      );
    }
  }

  bool _onTransition1 = false;
  bool _onTransition2 = false;
  @override
  void initState() {
    super.initState();
    loadPrefsAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D3557),
      body: Column(
        spacing: 0,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),

          _onTransition1
              ? Center(
                  child: SvgPicture.asset(
                    "assets/logo/Splash_screen_white_title.svg",
                  ),
                )
              : Container(),
          _onTransition2
              ? Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Mark ",
                        style: GoogleFonts.inter(
                          fontStyle: FontStyle.italic,
                          color: Color(0xFFF4A261),
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: "it. ",
                        style: GoogleFonts.inter(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: "Track ",
                        style: GoogleFonts.inter(
                          fontStyle: FontStyle.italic,
                          color: Color(0xFFF4A261),
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: "it. ",
                        style: GoogleFonts.inter(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: "Trust ",
                        style: GoogleFonts.inter(
                          fontStyle: FontStyle.italic,
                          color: Color(0xFFF4A261),
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: "it. ",
                        style: GoogleFonts.inter(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
