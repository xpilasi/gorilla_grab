import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gorilla_grab/widgets/alert_dialog.dart';

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
            return const CustomAlertDialog(
              titleError: 'Invalid credentials',
            );
          });
    });

    update();
    return Container();
  }

  Widget showingDialogPswNotMatching({required context}) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomAlertDialog(
              titleError: 'Not matching',
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

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomAlertDialog(
              titleError: 'Incorrect Password',
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
      print('Checking info');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              titleError: 'No connection',
            );
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

//No connection
  void noConnection({required context}) {
    showingDialogNoConnection(context: context);

    update();
  }
}
