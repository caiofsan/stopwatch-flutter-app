import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch_app/firebase_options.dart';
import 'package:stopwatch_app/view/about_screen.dart';
import 'package:stopwatch_app/view/editprofile_screen.dart';
import 'package:stopwatch_app/view/forgotpassword_screen.dart';
import 'package:stopwatch_app/view/history_screen.dart';
import 'package:stopwatch_app/view/profile_screen.dart';
import 'package:stopwatch_app/view/register_screen.dart';
import 'view/login_screen.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      title: '',
      routes: {
        'register': (context) => const RegisterScreen(),
        'login': (context) => const LoginScreen(),
        'about': (context) => const AboutScreen(),
        'forgot': (context) => const ForgotPasswordScreen(),
        'profile': (context) => const ProfileScreen(),
        'history': (context) => const HistoryScreen(),
        'edit': (context) => const EditProfileScreen(),
      },
    ),
  );
}
