import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safar/constants/nav_bar/nav_bar.dart';
// ignore: unused_import
import 'package:safar/presentation/pages/splashScreen/splashScreen.dart';

import 'package:supabase_flutter/supabase_flutter.dart';


void main() async { 
  WidgetsFlutterBinding.ensureInitialized(); 
  await Supabase.initialize(
    url: 'https://putmfvonnimjvavnnbwm.supabase.co',
    anonKey:   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB1dG1mdm9ubmltanZhdm5uYndtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDMxMDUzNjksImV4cCI6MjA1ODY4MTM2OX0.b54SsGdG42iqwQCcioAPqP-Qli2ixtwPe6_hU8t9GPQ',
    
  );
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
        '/':(context)=>NavBarDemoPage(),
     
      
      },
    );
  }
}

