import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safar/presentation/pages/loginPages/CredentialPage.dart';
<<<<<<< HEAD
import 'package:safar/presentation/pages/splashScreen/splashScreen.dart';
=======
>>>>>>> c4de96aa7b25f11f2c9dffde450be0863d412618
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:safar/presentation/pages/get start page/getstart_page.dart';

class Walkthroughscreen extends StatefulWidget {
  const Walkthroughscreen({super.key});

  @override
  State<Walkthroughscreen> createState() => _WalkthroughscreenState();
}

class _WalkthroughscreenState extends State<Walkthroughscreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

<<<<<<< HEAD
    final PageController _pageController=PageController(initialPage: 0);
    int _currentPageIndex=0;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
    
  }

    @override
=======
  @override
>>>>>>> c4de96aa7b25f11f2c9dffde450be0863d412618
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

<<<<<<< HEAD

  void _onSkipPressed(){
=======
  void _onSkipPressed() {
>>>>>>> c4de96aa7b25f11f2c9dffde450be0863d412618
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const CredentialPage()),
    );
  }

  void _onNextPressed() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

<<<<<<< HEAD
    final List<String> titles=[
      "Real-Time School Bus Tracking",
      "Instant Alerts, Always Informed",
      "One Account, Multiple Tracking"
    ];

    final List<String> descriptions=[
      "Know exactly where your school bus is  \nlive on the map.",
      "Get notified when the driver comes near your stop or reaches school.",
      "Track multiple buses easily from one account."
    ];

    final List<String> topSvgs=[
      "assets/walkthroughScreens/first_wts.svg",
      "assets/walkthroughScreens/Second_wts.svg",
      "assets/walkthroughScreens/third_wts.svg"



    ];


  
=======
  final List<String> titles = [
    "Real-Time Bus/Van Tracking",
    "Instant Alerts, Always Informed",
    "Add All Your Rides",
  ];

  final List<String> descriptions = [
    "Know exactly where your child's bus/van is — live on the map.",
    "Get notified when the driver comes online or reaches school.",
    "Track multiple buses easily from one account.",
  ];

  final List<String> topSvgs = [];
>>>>>>> c4de96aa7b25f11f2c9dffde450be0863d412618

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final ColorScheme = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: PageView(
        controller: _pageController,
<<<<<<< HEAD
        onPageChanged: (index){
          
=======
        onPageChanged: (index) {
>>>>>>> c4de96aa7b25f11f2c9dffde450be0863d412618
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: List.generate(3, (index) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * 0.4,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                ),
                padding: EdgeInsets.only(top: 35, left: 25, right: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: (_currentPageIndex + 1).toString(),
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextSpan(
                                text: " of 3",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _onSkipPressed();
                          },
                          child: Text(
                            "Skip",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
<<<<<<< HEAD
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
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                   topSvgs[index],
                   ),
                  
                  const Spacer(),
                ],
=======
                        ),
                      ],
                    ),
                  ],
                ),
>>>>>>> c4de96aa7b25f11f2c9dffde450be0863d412618
              ),
              const Spacer(),
              Text(
                titles[index],
                style: TextStyle(
                  color: ColorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  descriptions[index],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.black87,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          );
        }),
      ),
<<<<<<< HEAD
    bottomNavigationBar: Padding(
      padding: const EdgeInsets.only(bottom: 35,left: 25,right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
              AnimatedSmoothIndicator(
  activeIndex: _currentPageIndex,
  count: 3,
  effect: ExpandingDotsEffect(
    dotColor: const Color.fromARGB(149, 244, 163, 97), // light peach
    activeDotColor: const Color(0xFFF4A361), // darker orange for active
    expansionFactor: 2, // makes the active dot stretch out like a pill
    dotHeight: 12,
    dotWidth: 12,
    spacing: 5,
    radius: 8, // rounded enough to make the active dot pill-shaped
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
                
                
=======
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 35, left: 25, right: 25),
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
>>>>>>> c4de96aa7b25f11f2c9dffde450be0863d412618
              ),
            ),
            _currentPageIndex != 2
                ? GestureDetector(
                    onTap: () {
                      _onNextPressed();
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorScheme.secondary,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const GetStartPage(),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: 167,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: ColorScheme.secondary,
                      ),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
