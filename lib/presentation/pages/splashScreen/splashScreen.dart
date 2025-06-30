import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safar/presentation/pages/walkthroughScreens/WalkThroughScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
   bool _onTransition1=false;
   bool _onTransition2=false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Walkthroughscreen()));// Change to your next route
    });
       Future.delayed(const Duration(milliseconds:500), () {
    setState(() {
      _onTransition1 = true;
    });
  });
  Future.delayed(const Duration(milliseconds: 1500),(){

    setState(() {
      _onTransition2=true;

    });
  });
  }


  @override
  Widget build(BuildContext context) {
   
   
    return Scaffold(
      backgroundColor:Color(0xFF1D3557),
      body: Column(
        spacing: 0,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),

        _onTransition1?  Center(
            child:SvgPicture.asset("assets/logo/Splash_screen_white_title.svg"),
          ):Container(),
         _onTransition2? Text.rich(
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
                  color:Colors.white,
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
                  color: Colors.white,
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
                  color: Colors.white,
                  fontSize: 14,
                  ),

              ),


            ])
          ):Container(),
          const Spacer(flex: 2,),
        ],
      ),

    );
  }
}