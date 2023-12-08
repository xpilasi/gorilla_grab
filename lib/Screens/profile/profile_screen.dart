import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/profile/edit_profile_screen.dart';
import 'package:gorilla_grab/Screens/starting_screens/signup_screen.dart';
import 'package:gorilla_grab/Screens/starting_screens/welcome_screen.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/images.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/texts.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/widgets/list_tile_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: allAppBackground,
      body: Container(
        //Poner STACK sobre STACK
        color: tColorGreeny,
        child: Stack(children: [
          //Elementos del stack:
          //Elemento 1:
          Positioned(
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: tColorYellowLight,
                  child: Image.asset(
                      'assets/images/img/sharma-climbing-gava-1.jpg'),
                )),
          ),

          //PROFILE IMG BG
          const Positioned(child: ProfileBgImg()),

          //PROFILE LABEL
          const Positioned(
            top: 225,
            bottom: 0,
            left: 0,
            right: 0,
            child: ProfileLabel(),
          ),

          //PROFILE IMAGE
          const Positioned(
              top: 135, left: 0, right: 0, child: ProfilePicture()),

          //EDIT PROFILE BUTTON
          const Positioned(
            top: 250,
            right: 20,
            child: EditProfileButton(),
          ),

          //LOGO GORILLA
          const Positioned(
            bottom: 100,
            right: 10,
            left: 250,
            child: Opacity(
              opacity: 0.1,
              child: Image(
                image: AssetImage(
                  tImgIsoGorilla,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: tColorWhite.withAlpha(70),
      child: IconButton(
        icon: const Icon(Icons.edit, color: tColorWhite),
        onPressed: () => Get.to(() => EditProfileScreen()),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 90,
        backgroundColor: Colors.transparent,
        child: Container(
          height: 160,
          width: 160,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(tImgAvatar), // Ruta de la imagen
              fit: BoxFit.contain, // Ajuste de la imagen
            ),
          ),
        ));
  }
}

class ProfileBgImg extends StatelessWidget {
  const ProfileBgImg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 319,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.00, -1.00),
          end: Alignment(0, 1),
          colors: [tColorBottomSheet, Color.fromARGB(0, 206, 58, 154)],
        ),
      ),
    );
  }
}

class ProfileLabel extends StatelessWidget {
  const ProfileLabel({
    super.key,
  });
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [tColorBottomSheet, tColorBottomSheet],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(tSizesMargin),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: tSizesMargin),
            child: Text(
              tProfileName.toUpperCase(),
              style: tStyleBottomSheet,
            ),
          ),
          ProfileListTile(
              icon: Icons.location_on_rounded,
              title: tProfileLocation,
              editInfo: () => Get.to(() => EditProfileScreen())),
          const ProfileListTile(
              icon: CupertinoIcons.bolt_fill, title: tProfileClimber),
          ProfileListTile(icon: Icons.mail, title: tProfileMail),
          ProfileListTile(
            icon: CupertinoIcons.square_arrow_right_fill,
            title: tProfileLogOut,
            editInfo: signUserOut,
          )
        ]),
      ),
    );
  }
}
