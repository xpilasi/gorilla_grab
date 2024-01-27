import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gorilla_grab/constants/colors.dart';

class AuthController extends GetxController {
  //To show the circular progress while authenticating
  Widget showingDialogProgress({required context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    update();

    return Container();
  }

//To show a message dialog when the Email is wrong
  Widget showingDialogWrongEmail({required context}) {
    print('WRONG EMAIL');

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(
                'Invalid credentials',
              ),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Get.back();
                  },
                )
              ],
            );
          });
    });

    update();
    return Container();
  }

//To show a message dialog when the Password is wrong
  Widget showingDialogWrongPassword({required context}) {
    print('WRONG PSWD');

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      print('Checking info');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Incorrect Password'),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Get.back();
                  },
                )
              ],
            );
          });
    });

    update();
    return Container();
  }

//To show a message dialog when there is no connection
  Widget showingDialogNoConnection({required context}) {
    print('NO CONNECTION');

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(title: Text('No Internet connection'));
          });
    });

    update();
    return Container();
  }

//Email wrong: message to call
  void wrongEmailMessage({required context}) {
    showingDialogWrongEmail(context: context);
    update();
  }

//Password wrong: message to call
  void wrongEmailPassword({required context}) {
    showingDialogWrongPassword(context: context);

    update();
  }

//Password wrong: message to call
  void noConnection({required context}) {
    showingDialogNoConnection(context: context);

    update();
  }
}
