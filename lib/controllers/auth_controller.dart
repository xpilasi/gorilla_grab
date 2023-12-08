import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  Widget showingDialog({required context}) {
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
}
