import 'package:flutter/material.dart';
import 'package:safar/pages/loginPages/initialPage.dart';
import 'package:safar/pages/splashScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Ensure Flutter is ready before async calls

  await Supabase.initialize(
    url: 'https://putmfvonnimjvavnnbwm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB1dG1mdm9ubmltanZhdm5uYndtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDMxMDUzNjksImV4cCI6MjA1ODY4MTM2OX0.b54SsGdG42iqwQCcioAPqP-Qli2ixtwPe6_hU8t9GPQ',
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
        primaryColor: const Color(0xFFF5D54F),
        scaffoldBackgroundColor: Colors.white,
      
      
      ),
      initialRoute: '/',
      routes: {
        '/':(context)=>Splashscreen(),
        '/initialPage':(context)=>Initialpage(),
      },
    );
  }
}

