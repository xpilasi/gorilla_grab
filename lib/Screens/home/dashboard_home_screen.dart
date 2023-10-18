import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/home/dashboard_screen.dart';
import 'package:gorilla_grab/Screens/my_trainings/trainings/training_screen.dart';
import 'package:gorilla_grab/Screens/profile/profile_screen.dart';
import 'package:gorilla_grab/Screens/stats/stats_screen.dart';
import 'package:gorilla_grab/controllers/bottom_bar_controller.dart';
import 'package:gorilla_grab/widgets/bars.dart';

class DashBoardHomeScreen extends StatelessWidget {
  DashBoardHomeScreen({
    Key? key, //this.indexBottombar
  }) : super(key: key);
  // final indexBottombar;
  final BottomBarController bottomBarController =
      Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => IndexedStack(
              index: bottomBarController.currentIndex.value,
              children: [
                DashBoardScreen(),
                TrainingsScreen(),
                StatsScreen(),
                ProfileScreen(),
              ],
            )),
        extendBody: true,
        bottomNavigationBar:
            CustomBottomBar(bottomBarController: bottomBarController)
        //),
        );
  }
}
