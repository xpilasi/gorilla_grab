import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/profile/edit_profile_screen.dart';
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
//GRADIENT FROM TOP
          Positioned(
              child: Container(
            height: 319,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.00, -1.00),
                end: Alignment(0, 1),
                colors: [tColorBottomSheet, Color.fromARGB(0, 206, 58, 154)],
              ),
            ),
          )),
          Positioned(
            top: 225,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [tColorBottomSheet, tColorBottomSheetG2],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(tSizesMargin),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: tSizesMargin),
                        child: Text(
                          tProfileName.toUpperCase(),
                          style: tStyleBigTitle,
                        ),
                      ),
                      ProfileListTile(
                          icon: Icons.location_on_rounded,
                          title: tProfileLocation,
                          editInfo: () =>
                              Get.to(() => const EditProfileScreen())),
                      const ProfileListTile(
                          icon: CupertinoIcons.bolt_fill,
                          title: tProfileClimber),
                      const ProfileListTile(
                          icon: Icons.mail, title: tProfileMail),
                      const ProfileListTile(
                          icon: CupertinoIcons.square_arrow_right_fill,
                          title: tProfileLogOut),
                    ]),
              ),
            ),
          ),

          //PROFILE IMAGE
          Positioned(
              top: 135,
              left: 0,
              right: 0,
              child: CircleAvatar(
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
                  ))),
        ]),
      ),
    );
  }
}
