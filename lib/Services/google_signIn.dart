import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



Future<AuthResponse?> googleSignIn(BuildContext context) async {
  /// TODO: update the Web client ID with your own.
  try{
    final supabase=Supabase.instance.client;
  /// Web Client ID that you registered with Google Cloud.
  const webClientId = '983201528322-u2bn8v1pb9839co7lqterji3k5o1fdjp.apps.googleusercontent.com';

  /// TODO: update the iOS client ID with your own.
  ///
  /// iOS Client ID that you registered with Google Cloud.
  const iosClientId = '983201528322-8s9vbk7gfj52ogj4s6ldtaj8o68idufl.apps.googleusercontent.com';

  // Google sign in on Android will work without providing the Android
  // Client ID registered on Google Cloud.

  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: iosClientId,
    serverClientId: webClientId,
  );
  final googleUser = await googleSignIn.signIn();
  final googleAuth = await googleUser!.authentication;
  final accessToken = googleAuth.accessToken;
  final idToken = googleAuth.idToken;

  if (accessToken == null) {
    throw 'No Access Token found.';
  }
  if (idToken == null) {
    throw 'No ID Token found.';
  }

  return supabase.auth.signInWithIdToken(
    provider: OAuthProvider.google,
    idToken: idToken,
    accessToken: accessToken,
  );

  }catch(error){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text("Sign-In with Google failed try again"),
    ),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),)
    );
  }
  return null;

  
}
