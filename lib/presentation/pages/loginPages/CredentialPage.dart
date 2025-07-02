import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safar/Services/google_signIn.dart';
import 'package:safar/constants/app_theme/button_theme/responsive_button.dart';
import 'package:safar/constants/app_theme/text_theme/text_theme.dart';
import 'package:safar/constants/app_theme/textfield_theme/responsive_textfield.dart';
import 'package:safar/presentation/pages/get%20start%20page/getstart_page.dart';
import 'package:safar/presentation/pages/loginPages/otpVerifyPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CredentialPage extends StatefulWidget {
  const CredentialPage({super.key});

  @override
  State<CredentialPage> createState() => _CredentialPageState();
}

class _CredentialPageState extends State<CredentialPage> {
   final TextEditingController userNameController=TextEditingController();
    final TextEditingController mobileNumberController=TextEditingController();
    final TextEditingController emailIdController=TextEditingController();
    String countryCode = '+91';
     bool formValid=false;
     String? _userId;
     final supabase=Supabase.instance.client;

     void setSharedPrefs()async{
      final prefs=await SharedPreferences.getInstance();
      prefs.setBool("isloggedIn", true);

     }
     void checkformValid(){

      setState(() {
          final name = userNameController.text.trim();
  final phone = mobileNumberController.text.trim();
          formValid=name.isNotEmpty&&phone.length==10;
        
      });
    
     }
     @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameController.addListener(checkformValid);
    mobileNumberController.addListener(checkformValid);
    supabase.auth.onAuthStateChange.listen((data){
      setState(() {
        
        _userId=data.session?.user.id;
        print(_userId);
      });
    });
  }
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameController.dispose();
    emailIdController.dispose();
    mobileNumberController.dispose();
  }
  @override
  Widget build(BuildContext context) {

    
  


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Welcome to ", style: AppTextStyles.mainHeadline),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "SAFAR",
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 40,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                            wordSpacing: -0.1,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Center(
                          child: SvgPicture.asset("assets/App_icons/credential_page_icon.svg"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Please enter your name and mobile number to get started.",
                style: AppTextStyles.instructionText,
              ),
              const SizedBox(height: 15),
              Text("Name", style: AppTextStyles.textFieldHeadline),
              const SizedBox(height: 5),
              NameTextField(hintText: "Enter your name",controller: userNameController,),
              const SizedBox(height: 15),
              Text("Mobile Number", style: AppTextStyles.textFieldHeadline),
              const SizedBox(height: 5),
              Row(
                children: [
                  CountryCodeSelector(onCodeChanged: (newcode){
                    countryCode=newcode;
                  },),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PhoneTextField(hintText: "Enter your mobile number",controller: mobileNumberController,),
        
                  ),
                ],
                
              ),
                Padding(
        padding: const EdgeInsets.all(20),
        child: ResponsiveButton(text: 'Send OTP',outlined: !formValid, onPressed: 
          formValid?(){
Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OtpVerificationPage(userName: userNameController.text.trim(),mobileNumber: mobileNumberController.text.trim(), countryCode: countryCode,)));
          }
          :(){
            ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Center(
      child: 
        userNameController.text.trim().isEmpty &&
                mobileNumberController.text.trim().isEmpty
            ? const Text("Please enter your name and mobile number.")
            : userNameController.text.trim().isEmpty
                ? const Text("Please enter your name to proceed.")
                : const Text("Please enter a valid 10-digit mobile number."),
    ),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
    // backgroundColor: Colors.redAccent, // Optional: error theme
  ),
);

          
         },
         ),
      ),
              const SizedBox(height: 5,),

              Center(
                child: 
                Column(
                  spacing: 20,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 2,
                          
                             decoration: BoxDecoration(
                               color: Color(0xff6c757d),
                               borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                            
                        ),
                        
                       const SizedBox(width: 10,),
                        Text("OR"),
                            const SizedBox(width: 10,),
                        Container(
                          width: 100,
                          height: 2,
                       
                          decoration: BoxDecoration(
                               color: Color(0xff6c757d),
                               borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                     
                            
                      ],
                    ),
                     GestureDetector(
                onTap: () async{
                  print("google sign in tap");
                 dynamic user;
              //  await Supabase.instance.client.auth.signInWithOAuth(OAuthProvider.google);
              if(!kIsWeb&&(Platform.isAndroid||Platform.isIOS)){
               user=await googleSignIn(context);
              }
              else{
             user=   await supabase.auth.signInWithOAuth(
  OAuthProvider.google,
  redirectTo: kIsWeb ? null : 'https://putmfvonnimjvavnnbwm.supabase.co/auth/v1/callback', // Optionally set the redirect link to bring back the user via deeplink.
  authScreenLaunchMode:
      kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication, // Launch the auth screen in a new webview on mobile.
);


              }
              if(user!=null){
                setSharedPrefs();
                print(user);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>GetStartPage()));
              }


                },
                child: SvgPicture.asset("assets/App_icons/google_icon.svg"))
                  ],
                ),
              ),
             
                
               
            ],
          ),
        ),
      ),
    
    );
  }
}
