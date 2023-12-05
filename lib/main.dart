import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/sign_in/signin_screen.dart';
import 'package:gorilla_grab/themes/main_theme.dart';
import 'Screens/home/dashboard_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Restringe la orientación a retrato
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GorillaGrab',
      theme: GorillaTheme.lightGorillaTheme,
      home: SignInScreen(),
    );
  }
}
