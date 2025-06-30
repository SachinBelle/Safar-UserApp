import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safar/pages/loginPages/CredentialPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Walkthroughscreen extends StatefulWidget {


   Walkthroughscreen({super.key,});

  @override
  State<Walkthroughscreen> createState() => _WalkthroughscreenState();
}

class _WalkthroughscreenState extends State<Walkthroughscreen> {

    final PageController _pageController=PageController(initialPage: 0);
    int _currentPageIndex=0;

    @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  void _onSkipPressed(){
    _navigateToLogin();
  }


  void _navigateToLogin(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const CredentialPage()));
  }

  void _onNextPressed(){
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300)
    , 
    curve: Curves.easeInOut,);
  }

    final List<String> titles=[
      "Real-Time Bus/Van Tracking",
      "Instant Alerts, Always Informed",
      "Add All Your Rides"
    ];

    final List<String> descriptions=[
      "Know exactly where your child's bus/van is — live on the map.",
      "Get notified when the driver comes online or reaches school.",
      "Track multiple buses easily from one account."
    ];

    final List<String> topSvgs=[];


  

  @override
  Widget build(BuildContext context)

 
   {

      final ColorScheme=Theme.of(context).colorScheme;
       final screenHeight=MediaQuery.of(context).size.height;
     


    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index){
          setState(() {
            
            _currentPageIndex=index;
          });
        },
        children:List.generate(3,(index){

          return  Column(
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
                            text: (_currentPageIndex+1).toString(),
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
                      GestureDetector(
                        onTap: (){
                          _onSkipPressed();
                        },
                        child: Text("Skip",style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                              ),),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            Text(titles[index],style: TextStyle(
              color: ColorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              
              ),),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(descriptions[index],
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
          
        );
        })
        
        
        
      ),
    bottomNavigationBar: Padding(
      padding: const EdgeInsets.only(bottom: 35,left: 25,right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
                AnimatedSmoothIndicator(
                  activeIndex: _currentPageIndex,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotColor: Color.fromARGB(149, 244, 163, 97),
                    activeDotColor: ColorScheme.secondary,
                    expansionFactor: 1.5,
                    radius: 8,
                  ),
                  ),
            _currentPageIndex!=2?  GestureDetector(
                onTap: (){
                 _onNextPressed();
      
                },
                child: Container(
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
              ):
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context)=>CredentialPage())
                  );
                  
                },
                child:Container(
                  height: 60,
                  width: 167,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: ColorScheme.secondary,
                  ),
                  child: Center(
                    child: Text("Get Started",style: TextStyle(color: Colors.white),),
                  ),
                ),
                
                
              ),
              ],
      ),
    ),
      
    
    );
  }
}