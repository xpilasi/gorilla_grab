import 'package:get/get.dart';
import 'package:gorilla_grab/constants/colors.dart';

class CustomSnackBarUserCreated {
   showSnackbarUserCreated({required String title, required String subtitle}) {
    Get.snackbar(title, subtitle,
        snackPosition: SnackPosition.TOP,
        backgroundColor: tColorWhite,
        colorText: tColorBlacky);
  }
}