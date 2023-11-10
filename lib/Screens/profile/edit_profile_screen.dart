import 'package:flutter/material.dart';
import 'package:gorilla_grab/constants/texts.dart';
import 'package:gorilla_grab/constants/variables.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameProfile = TextEditingController(text: tProfileName);
    return const Scaffold(
      backgroundColor: allAppBackground,
      body: Center(
        child: Text('EditProfileScreen OK'),
      ),
    );
  }
}
