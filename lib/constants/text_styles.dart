//TEXT STYLES

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/variables.dart';

const String font1 = outfit;
const String font2 = roboto;
const String font3 = robotoC;
const String font4 = barlow;
const String font5 = chivoMono;

const String fontTitles = font1;
const String fontSubTitles = font1;
const String fontButtons = font1;
const String fontInputs = font1;
const String fontAppBar = font1;
const String fontCards = font1;
const String fontTimer = font5;
const String fontRecords = font5;

Color primaryFontColor() {
  Color primaryColorFont = tColorBlacky;
  allAppBackground == tColorBottomSheet
      ? primaryColorFont = tColorWhite
      : primaryColorFont = tColorBlacky;
  return primaryColorFont;
}

//TITLES - SUBTITLES
TextStyle tStyleBigTitle = TextStyle(
    color: primaryFontColor(),
    fontSize: 28,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
TextStyle tStyleBigTitleTraining = const TextStyle(
    color: tColorPinky,
    fontSize: 28,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
TextStyle tStyleBigTitlePinky = const TextStyle(
    color: tColorPinky,
    fontSize: 40,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
TextStyle tStyleBigSubTitle = TextStyle(
    color: primaryFontColor(),
    fontSize: 17,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w500,
    letterSpacing: 0);
TextStyle tStyleTitles = TextStyle(
    color: primaryFontColor(),
    fontSize: 18,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w500,
    letterSpacing: -1);
TextStyle tStyleSubTitles = TextStyle(
    color: primaryFontColor(),
    fontSize: 17,
    fontFamily: fontSubTitles,
    fontWeight: FontWeight.w300,
    letterSpacing: 0);
TextStyle tStyleTitleSession = TextStyle(
    color: primaryFontColor(),
    fontSize: 20,
    fontFamily: fontSubTitles,
    fontWeight: FontWeight.w500,
    letterSpacing: -1);

//APPBAR
const TextStyle tStyleStandardAppBar = TextStyle(
    color: tColorWhite,
    fontSize: 20,
    fontFamily: fontAppBar,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleStandardAppBarBg = TextStyle(
    color: tColorWhite,
    fontSize: 20,
    fontFamily: fontAppBar,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);

//DASHBOARD
const TextStyle tStyleDashBoardBigRecord = TextStyle(
    color: tColorPinky,
    fontSize: 95,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: -5);
const TextStyle tStyleDashBoardSmallRecord = TextStyle(
    color: tColorPinky,
    fontSize: 30,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleDashBoardSmallRecordTextM = TextStyle(
    color: tColorWhite,
    fontSize: 15,
    fontFamily: fontTimer,
    fontWeight: FontWeight.w500,
    letterSpacing: 0);
const TextStyle tStyleDashBoardSmallRecordText = TextStyle(
    color: tColorWhite,
    fontSize: 15,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w500,
    letterSpacing: 0);
const TextStyle tStyleDashBoardSubtitle = TextStyle(
    color: tColorPinky,
    fontSize: 20,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);

const TextStyle tStyleDashBoardRecord = TextStyle(
    color: tColorWhite,
    fontSize: 60,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: -5);
const TextStyle tStyleDashBoardExercise = TextStyle(
    color: tColorWhite,
    fontSize: 15,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleDashBoardPositive = TextStyle(
    color: tColorGreeny,
    fontSize: 35,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);

const TextStyle tStyleDashBoardNegative = TextStyle(
    color: tColorPrimary_8,
    fontSize: 35,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleDashBoardMesure = TextStyle(
    color: tColorWhite,
    fontSize: 15,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);

const TextStyle tStyleDashBoardTitles = TextStyle(
    color: tColorWhite,
    fontSize: 20,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleDashBoardTraining = TextStyle(
    color: tColorWhite,
    fontSize: 15,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleDashBoardDuration = TextStyle(
    color: tColorPinky,
    fontSize: 15,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleDashBoardDate = TextStyle(
    color: tColorPrimary_6,
    fontSize: 15,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleDashBoardTopNum = TextStyle(
    color: tColorBottomSheetG,
    fontSize: 14,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);

//INPUTS
const TextStyle tStyleInputLabel = TextStyle(
    color: tColorShadow,
    fontSize: 20,
    fontFamily: fontInputs,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleInputLabelDark = TextStyle(
    color: tColorShadow,
    fontSize: 20,
    fontFamily: fontInputs,
    fontWeight: FontWeight.w500,
    letterSpacing: 0);
const TextStyle tStyleInput = TextStyle(
    color: tColorPink,
    fontSize: 20,
    fontFamily: fontInputs,
    fontWeight: FontWeight.w600,
    letterSpacing: 0);
const TextStyle tStyleInputHint = TextStyle(
    color: tColorShadow,
    fontSize: 20,
    fontFamily: fontInputs,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleInputSwitch = TextStyle(
    color: tColorShadowy,
    fontSize: 20,
    fontFamily: fontInputs,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleInputButton = TextStyle(
    color: tColorWhite,
    fontSize: 20,
    fontFamily: fontInputs,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleInputIsRep = TextStyle(
    color: tColorShadowy,
    fontSize: 20,
    fontFamily: fontInputs,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleInputIsNotSelected = TextStyle(
    color: tColorShadowy,
    fontSize: 20,
    fontFamily: fontInputs,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleInputIsNotRep = TextStyle(
    color: tColorPink,
    fontSize: 20,
    fontFamily: robotoC,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);

//CARDS:
const TextStyle tStyleCardTraining = TextStyle(
    color: tColorPinky,
    fontSize: 25,
    fontFamily: fontCards,
    fontWeight: FontWeight.w700,
    height: 0.9,
    letterSpacing: -1);
const TextStyle tStyleCardSession = TextStyle(
    color: tColorPinky,
    fontSize: 17,
    fontFamily: fontCards,
    fontWeight: FontWeight.w600,
    height: 0.9,
    letterSpacing: 0);
const TextStyle tStyleCardNumberSession = TextStyle(
    color: tColorWhite,
    fontSize: 17,
    fontFamily: fontRecords,
    fontWeight: FontWeight.w600,
    height: 0.9,
    letterSpacing: 0);
const TextStyle tStyleCardIcons = TextStyle(
    color: tColorPinky,
    fontSize: 16,
    fontFamily: fontTimer,
    fontWeight: FontWeight.w600,
    letterSpacing: 0);
const TextStyle tStyleCardExercises = TextStyle(
    color: tColorWhite,
    fontSize: 16,
    fontFamily: fontCards,
    fontWeight: FontWeight.w600,
    letterSpacing: 0);

//BUTTONS:
const TextStyle tStyleNewSessionButton = TextStyle(
    color: tColorWhite,
    fontSize: 14,
    fontFamily: fontButtons,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleNewSmallButton = TextStyle(
    color: tColorWhite,
    fontSize: 17,
    fontFamily: fontButtons,
    fontWeight: FontWeight.w700, //oo
    letterSpacing: 0);
const TextStyle tStyleProfileText = TextStyle(
    color: tColorWhite,
    fontSize: 17,
    fontFamily: fontButtons,
    fontWeight: FontWeight.w300, //oo
    letterSpacing: 0);
const TextStyle tStyleCancelButton = TextStyle(
    color: tColorPinky,
    fontSize: 15,
    fontFamily: fontButtons,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);
const TextStyle tStyleConfirmButton = TextStyle(
    color: tColorWhite,
    fontSize: 15,
    fontFamily: fontButtons,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);

//BOTTOM SHEET
const TextStyle tStyleBottomSheet = TextStyle(
    color: tColorWhite,
    fontSize: 20,
    fontFamily: fontButtons,
    fontWeight: FontWeight.w400,
    letterSpacing: 0);
const TextStyle tStyleBottomSheetDark = TextStyle(
    color: tColorBottomSheetG,
    fontSize: 20,
    fontFamily: fontButtons,
    fontWeight: FontWeight.w400,
    letterSpacing: 0);
const TextStyle tStyleBottomSheetSmaller = TextStyle(
    color: tColorWhite,
    fontSize: 18,
    fontFamily: fontButtons,
    fontWeight: FontWeight.w400,
    letterSpacing: 0);
const TextStyle tStyleBottomSheetHighlighted = TextStyle(
    color: tColorPinky,
    height: 1,
    fontSize: 16,
    fontFamily: fontButtons,
    fontWeight: FontWeight.w400,
    letterSpacing: 0);

const TextStyle tStyleBottomSheetCommentHint = TextStyle(
    color: tColorWhite,
    fontSize: 16,
    fontFamily: fontButtons,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    letterSpacing: 0);

const TextStyle tStyleBottomSheetComment = TextStyle(
    color: tColorPinky,
    fontSize: 16,
    fontFamily: fontButtons,
    fontWeight: FontWeight.w400,
    letterSpacing: 0);

//RECORDS:
const TextStyle tStyleListCountdown = TextStyle(
    color: tColorPrimary_4,
    fontSize: 200,
    fontFamily: fontSubTitles,
    fontWeight: FontWeight.w600,
    letterSpacing: 0);

const TextStyle tStyleListTileExerciseName = TextStyle(
    color: tColorWhite,
    fontSize: 15,
    fontFamily: fontSubTitles,
    fontWeight: FontWeight.w600,
    letterSpacing: 0);
const TextStyle tStyleListTileLR = TextStyle(
    color: tColorWhite,
    fontSize: 13,
    fontFamily: fontRecords,
    fontWeight: FontWeight.w600,
    letterSpacing: 0);
const TextStyle tStyleListTileCR = TextStyle(
    color: tColorPrimary_4,
    fontSize: 13,
    fontFamily: fontRecords,
    fontWeight: FontWeight.w600,
    letterSpacing: 0);
const TextStyle tStyleGapRecordsPositive = TextStyle(
    color: tColorGreeny,
    fontSize: 13,
    fontFamily: fontRecords,
    fontWeight: FontWeight.w600,
    letterSpacing: 0);
const TextStyle tStyleGapRecordsNegative = TextStyle(
    fontSize: 13,
    color: tColorPrimary_8,
    fontFamily: fontRecords,
    fontWeight: FontWeight.w600,
    letterSpacing: 0);

//STOPWATCH
const TextStyle tStyleStopwatchIndex = TextStyle(
    color: tColorWhite,
    fontSize: 17,
    fontFamily: fontTimer,
    fontWeight: FontWeight.w500,
    letterSpacing: 0);
const TextStyle tStyleStopwatch = TextStyle(
    color: tColorWhite,
    fontSize: 20,
    fontFamily: fontTimer,
    fontWeight: FontWeight.w300,
    letterSpacing: 0);
const TextStyle tStyleStopwatchBig = TextStyle(
    color: tColorWhite,
    fontSize: 39,
    fontFamily: fontCards,
    fontWeight: FontWeight.w600,
    letterSpacing: 0);
const TextStyle tStyleStopwatchBigTimer = TextStyle(
    color: tColorPinky,
    fontSize: 52,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w600,
    letterSpacing: -3);
const TextStyle tStyleStopwatchInside = TextStyle(
  color: tColorWhite,
  fontSize: 70,
  fontFamily: fontTimer,
  fontWeight: FontWeight.w400,
  letterSpacing: -7,
);

//POPUP MENU:
const TextStyle tStylePopUpMenu = TextStyle(
    color: tColorWhite,
    fontSize: 17,
    fontFamily: fontCards,
    fontWeight: FontWeight.w600,
    height: 0.9,
    letterSpacing: -1);

//EMPTY LIST:

TextStyle tStyleEmptyTitle = TextStyle(
    color: primaryFontColor(),
    fontSize: 28,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w700,
    letterSpacing: 0);

const TextStyle tStyleEmptySubtitle = TextStyle(
    color: tColorPinky,
    fontSize: 14,
    fontFamily: fontButtons,
    fontWeight: FontWeight.w500,
    letterSpacing: 0);

//RepSession:
const TextStyle tStyleRep = TextStyle(
    color: tColorPinky,
    fontSize: 250,
    fontFamily: fontTimer,
    fontWeight: FontWeight.w500,
    letterSpacing: 0);
const TextStyle tStyleRepTitle = TextStyle(
    color: tColorWhite,
    fontSize: 40,
    fontFamily: fontTitles,
    fontWeight: FontWeight.w500,
    letterSpacing: 0);
//RepSession:
const TextStyle tStyleStatsBarChart = TextStyle(
    color: tColorWhite,
    fontSize: 13,
    fontFamily: fontCards,
    fontWeight: FontWeight.w500,
    letterSpacing: 0);

//Onboarding

const TextStyle tStyleOnboardingTitle = TextStyle(
    color: tColorWhite,
    fontSize: 16,
    fontFamily: fontCards,
    fontWeight: FontWeight.w900,
    letterSpacing: 0);

const TextStyle tStyleOnboardingSubtitle = TextStyle(
    color: tColorWhite,
    fontSize: 15,
    fontFamily: fontCards,
    fontWeight: FontWeight.w300,
    letterSpacing: 0);

const TextStyle tStyleOnboardingSignUp = TextStyle(
    color: tColorTurk,
    fontSize: 15,
    fontFamily: fontCards,
    fontWeight: FontWeight.w300,
    letterSpacing: 0);

const TextStyle tStyleOnboardingText = TextStyle(
    color: tColorWhite,
    fontSize: 15,
    fontFamily: fontCards,
    fontWeight: FontWeight.w300,
    letterSpacing: 0);

const TextStyle tStyleOnboardingTextLink = TextStyle(
    color: tColorPinky,
    decoration: TextDecoration.underline,
    fontSize: 15,
    fontFamily: fontCards,
    fontWeight: FontWeight.w600,
    letterSpacing: 0);

const TextStyle tStyleOnboardingForgotPswd = TextStyle(
    color: tColorPinky,
    fontSize: 15,
    fontFamily: fontCards,
    fontWeight: FontWeight.w500,
    letterSpacing: 0);

// Edit and delete Trainings

const TextStyle tStyleEditAndDeleteTraining = TextStyle(
    color: tColorWhite,
    fontSize: 15,
    fontFamily: fontCards,
    fontWeight: FontWeight.w500,
    letterSpacing: 0);
