//GENERAL VARIABLES

import 'package:flutter/material.dart';

import 'colors.dart';
import 'images.dart';

var tPaddingIconsBottomBar = const EdgeInsets.only(top: 0, bottom: 0);

//Font helper:
const String robotoC = 'Roboto_condensed';
const String barlow = 'Barlow';
const String robotoMono = 'Roboto_mono';
const String chivoMono = 'Chivo_mono';
const String roboto = 'Roboto';
const String roboto_2 = 'Roboto_2';
const String timesNewRomance = 'Times_new_romance_2';
const String lexend = 'Lexend';
const String outfit = 'Outfit';

//ICONS:

const IconData timerIcon = Icons.timer_outlined;
const IconData repIcon = Icons.refresh_rounded;
const Color timerColor = tColorGreen;
const Color repColor = tColorPink;

//Radius

const allBoxRadius = 20.0;

//Backgrounds:

const allAppBackground = tColorBottomSheet;
const appBackground = backgroundOnlyNeonDark;
const backgrounGorillaDecoration = BoxDecoration(
  color: tColorPrimary_5,
  image: DecorationImage(
    alignment: Alignment.center,
    image: AssetImage(tImgLogoBigGoillaLighter), // Ruta de la imagen de fondo
  ),
);
const backgroundOnlyWhite = BoxDecoration(
  color: tColorWhite,
);
const backgroundOnlyPink = BoxDecoration(
  color: tColorPink,
);
const backgroundOnlyPrimaryLighter = BoxDecoration(
  color: tColorPrimaryLighter,
);

const backgroundOnlyPrimary_5 = BoxDecoration(
  color: tColorPrimary_5,
);

const backgroundOnlyNeonDark = BoxDecoration(
  color: tColorBottomSheet,
);

//Container outlined primary color:
var shapeOutlinedPrimary = ShapeDecoration(
  shape: RoundedRectangleBorder(
    side: const BorderSide(width: 3.50, color: tColorPrimary),
    borderRadius: BorderRadius.circular(10),
  ),
);

//Container outlined primary color:
var shapeOutlinedTimer = ShapeDecoration(
  shape: RoundedRectangleBorder(
    side: const BorderSide(width: 3.50, color: tColorPink),
    borderRadius: BorderRadius.circular(10),
  ),
);

//Shadows circle avatar_
var boxShadow = BoxDecoration(
  shape: BoxShape.circle,
  boxShadow: [
    BoxShadow(
      color: tColorBlack.withOpacity(0.3), // Color y opacidad de la sombra
      spreadRadius:
          2, // Cuánto se extiende la sombra desde el círculo (ajusta según tus preferencias)
      blurRadius: 9, // Desenfoque de la sombra (ajusta según tus preferencias)
      offset: const Offset(
          0, 0), // Desplazamiento de la sombra en (horizontal, vertical)
    ),
  ],
);

var sessionDecorationShadow = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: tColorBlackyLight.withOpacity(0.5),
        blurRadius: 16,
        offset: const Offset(0, 0),
        spreadRadius: 3, // Desplazamiento de la sombra (horizontal, vertical)
      )
    ],
    borderRadius: BorderRadius.circular(20),
    gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [tColorPrimaryG, tColorPrimary]));

BoxShadow boxShadowContainers = BoxShadow(
    //blurStyle: BlurStyle.inner,
    color: tColorBlackyLight.withOpacity(0.5),
    blurRadius: 12,
    offset: const Offset(0, 3),
    spreadRadius: 3 // Desplazamiento de la sombra (horizontal, vertical)
    );

BoxShadow boxShadowContainersLight = BoxShadow(
    //blurStyle: BlurStyle.inner,
    color: tColorBlackyLight.withOpacity(0.2),
    blurRadius: 12,
    offset: const Offset(0, 0),
    spreadRadius: 3 // Desplazamiento de la sombra (horizontal, vertical)
    );
