import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/constants/texts.dart';

class ProfileController extends GetxController {
//Loading data from Firebase
  late final db = FirebaseFirestore.instance;
  late final usersMap = db.collection('users');
  final userEmail = FirebaseAuth.instance.currentUser!.email;

  late final userProfileData = FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .collection('profile');

//Recovering profile data:

  var profile = {
    'name': 'John',
    'lastName': 'Doe',
    'city': 'noMansLand',
    'country': 'noCountry',
    'email': 'noEmail',
    'climbinSince': 2000,
    'nationality': 'lostPerson',
  };
  @override
  void onInit() {
    super.onInit();
    _loadProfile();
  }

  void _loadProfile() async {
    final userProfile = await userProfileData.get();
    final profileDocument = userProfile.docs.first;

    profile['name'] = profileDocument['name'];
    profile['lastName'] = profileDocument['lastName'];
    profile['city'] = profileDocument['city'];
    profile['country'] = profileDocument['country'];
    profile['email'] = profileDocument['email'];
    profile['climbinSince'] = profileDocument['climbinSince'];
    profile['nationality'] = profileDocument['nationality'];
  }

//To update the profile basic data

  void updateProfileBasicData(
      {required name, required lastName, required email, required password}) {
    tProfileName = name;
    tProfileLastName = lastName;
    tProfileMail = email;
    tProfilePassword = password;

    update();
    Get.back();
  }

  //To show or not the clear icon
  bool isVisible = false;
  void showClearIcon({required String isFilled}) {
    isVisible = isFilled.isNotEmpty;
    update();
  }

  Widget tryWidget({required Widget widget}) {
    try {
      return widget;
    } catch (e) {
      return Text('$e');
    }
  }
}
