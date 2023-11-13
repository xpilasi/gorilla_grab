import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/profile/profile_screen.dart';
import 'package:gorilla_grab/constants/texts.dart';

class ProfileController extends GetxController {
//To update the profile basic data

  void updateProfileBasicData(
      {required name, required lastName, required email, required password}) {
    tProfileName = name;
    tProfileLastName = lastName;
    tProfileMail = email;
    tProfilePassword = password;
    print(name);

    update();
    //Get.to(() => ProfileScreen());
    Get.back();
  }
}
