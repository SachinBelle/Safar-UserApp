import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safar/presentation/pages/splashScreen/splashScreen.dart';

// import 'package:safar/pages/splashScreen.dart';


void main() async { 
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safar',
      theme: ThemeData(
         brightness: Brightness.light,
        colorScheme:ColorScheme.fromSeed(
          seedColor: const Color(0xFF1D3557),
          primary: const Color(0xFF1D3557),
          secondary: const Color(0xFFF4A261),
        ) ,
      
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(
          
        )

        
      
      ),
      initialRoute: '/',
      routes: {
        '/':(context)=>Splashscreen(),
     
      
      },
    );
  }
}

