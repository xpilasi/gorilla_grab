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

// prueba
  // late final userProfile = userProfileData.get();
  // late final profileDocument = userProfile.docs.first;
// fin prueba

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
    update();
  }

  var profile = {
    'name': 'John',
    'lastName': 'Doe',
    'city': 'noMansLand',
    'country': 'noCountry',
    'email': 'noEmail',
    'climbingSince': 2000,
    'nationality': 'lostPerson',
  };

  void _loadProfile() async {
    print(userEmail.toString());

    final userProfile = await userProfileData.get();
    print(userProfile);
    final profileDocument = userProfile.docs.first;

    profile['name'] = profileDocument['name'];
    profile['lastName'] = profileDocument['lastName'];
    profile['city'] = profileDocument['city'];
    profile['country'] = profileDocument['country'];
    profile['email'] = profileDocument['email'];
    profile['climbingSince'] = profileDocument['climbingSince'];
    profile['nationality'] = profileDocument['nationality'];

    int now = DateTime.now().year;
    int climbingSince = int.parse(profile['climbingSince'].toString());
    int yearsClimbing = now - climbingSince;
    profile['climbingSince'] = yearsClimbing;

    update();
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
