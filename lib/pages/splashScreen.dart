import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safar/pages/walkthroughScreens/WalkThroughScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
   bool _onTransition=false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Walkthroughscreen(screenNo: 1, subTitle: "Know exactly where your child's bus/van is — live on the map.", title: "Real-Time Bus/Van Tracking")));// Change to your next route
    });
       Future.delayed(const Duration(seconds: 2), () {
    setState(() {
      _onTransition = true;
    });
  });
  }


  @override
  Widget build(BuildContext context) {
   
   
    return Scaffold(
      backgroundColor:_onTransition?Color(0xFF1D3557):Colors.white,
      body: Column(
        spacing: 0,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),

          Center(
            child:_onTransition?SvgPicture.asset("assets/logo/Splash_screen_white_title.svg") :SvgPicture.asset("assets/logo/splash_screen_blue_title.svg")
          ),
          Text.rich(
            TextSpan(children:[
              TextSpan(
                text: "Mark ",
                style: GoogleFonts.inter(
                  fontStyle: FontStyle.italic,
                  color:  Color(0xFFF4A261),
                  fontSize: 14,
                  ),

              ),
              TextSpan(
                text: "it. ",
                 style: GoogleFonts.inter(
                  fontStyle: FontStyle.italic,
                  color: _onTransition?Colors.white:Color(0xFF1D3557),
                  fontSize: 14,
                  ),

              ),
              TextSpan(
                text: "Track ",
                style: GoogleFonts.inter(
                  fontStyle: FontStyle.italic,
                  color:  Color(0xFFF4A261),
                  fontSize: 14,
                  ),

              ),
               TextSpan(
                text: "it. ",
                 style: GoogleFonts.inter(
                  fontStyle: FontStyle.italic,
                  color: _onTransition?Colors.white:Color(0xFF1D3557),
                  fontSize: 14,
                  ),

              ),
               TextSpan(
                text: "Trust ",
                style: GoogleFonts.inter(
                  fontStyle: FontStyle.italic,
                  color:  Color(0xFFF4A261),
                  fontSize: 14,
                  ),

              ),
               TextSpan(
                text: "it. ",
                 style: GoogleFonts.inter(
                  fontStyle: FontStyle.italic,
                  color: _onTransition?Colors.white:Color(0xFF1D3557),
                  fontSize: 14,
                  ),

              ),


            ])
          ),
          const Spacer(flex: 2,),
        ],
      ),

    );
  }
}