import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/home/dashboard_home_screen.dart';
import 'package:gorilla_grab/Screens/starting_screens/log_in_screen.dart';
import 'package:gorilla_grab/Screens/starting_screens/welcome_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('NO USER LOGGED IN');
        Get.offAll(() => WelcomeScreen());
      } else {
        print('USER EXISTS');
        Get.offAll(() => DashBoardHomeScreen());
      }
    });

    return Container();
  }
}
