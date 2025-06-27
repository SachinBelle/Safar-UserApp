import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Walkthroughscreen extends StatelessWidget {
  final int screenNo;
  final String title;
  final String subTitle;
  const Walkthroughscreen({super.key,required this.screenNo,required this.subTitle,required this.title});
  @override
  Widget build(BuildContext context)

 
   {
      final ColorScheme=Theme.of(context).colorScheme;
       final screenHeight=MediaQuery.of(context).size.height;


    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight*0.4,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(25) ,bottomRight: Radius.circular(25)),
              color: Theme.of(context).colorScheme.primary,
            ),
            padding: EdgeInsets.only(top: 35,left: 25,right: 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: screenNo.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w900
                          ),
                        ),
                        TextSpan(
                          text: " of 3",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )
                        )
                      ]),
          
                    ),
                    Text("Skip",style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),)
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
          Text(title,style: TextStyle(
            color: ColorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            
            ),),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(subTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  color: Colors.black87,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          const Spacer(flex: 2,),
          
        ],
        
      ),
    bottomNavigationBar: Padding(
      padding: const EdgeInsets.only(bottom: 35,left: 25,right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
                AnimatedSmoothIndicator(
                  activeIndex: screenNo-1,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotColor: Color.fromARGB(149, 244, 163, 97),
                    activeDotColor: ColorScheme.secondary,
                    expansionFactor: 1.5,
                    radius: 8,
                  ),
                  ),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorScheme.secondary
                ),
                child: Center(
                  child: Icon(Icons.arrow_forward,color: Colors.white,size: 30,),
                ),
              ),
              ],
      ),
    ),
      

    );
  }
}