import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/constants/texts.dart';

class ProfileController extends GetxController {
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
