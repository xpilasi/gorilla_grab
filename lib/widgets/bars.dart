import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/models/exercise_model.dart';
import 'package:gorilla_grab/models/rep_provisional_records_model.dart';
import 'package:gorilla_grab/models/session_provisional_model.dart';
import 'package:gorilla_grab/models/timer_provisional_records_model.dart';
import 'package:gorilla_grab/Screens/my_trainings/session/training_session_provisional_screen.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/controllers/bottom_bar_controller.dart';
import 'package:gorilla_grab/controllers/exercises_controller.dart';
import 'package:gorilla_grab/controllers/records_controller.dart';
import 'package:gorilla_grab/controllers/trainings_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

//BOTTOM BAR
class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.bottomBarController,
  });

  final BottomBarController bottomBarController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(tSizesMargin),
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent),
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      //color: tColorPrimary,
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [tColorPrimary, tColorPrimary_4]),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 400,
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.transparent),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: BottomNavigationBar(
                        elevation: 0,
                        iconSize: 30,
                        selectedFontSize: 0,
                        backgroundColor: Colors.transparent,
                        type: BottomNavigationBarType.fixed,
                        unselectedItemColor: tColorWhite,
                        fixedColor: tColorPinky,
                        currentIndex: bottomBarController.currentIndex.value,
                        onTap: bottomBarController.changePage,
                        showSelectedLabels:
                            false, // Ocultar las etiquetas seleccionadas
                        showUnselectedLabels: false,
                        items: [
                          BottomNavigationBarItem(
                            icon: Icon(
                              MdiIcons.homeVariant,
                            ),
                            label: '',
                            //label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(
                              MdiIcons.flash,
                            ),
                            label: '',
                            //label: '',
                          ),
                          const BottomNavigationBarItem(
                            icon: Icon(
                              Icons.auto_graph_sharp,
                            ),
                            label: '',
                            //label: '',
                          ),
                          const BottomNavigationBarItem(
                            icon: Icon(
                              Icons.person,
                            ),
                            label: '',
                            //label: '',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}

//APPBAR
class CustomAppBar extends StatelessWidget {
  final String appBarTitle;

  const CustomAppBar({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: tSizesBarAppHeight,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        appBarTitle,
        style: tStyleStandardAppBar,
      ),
    );
  }
}

//APPBAR
class CustomAppBarBack extends StatelessWidget {
  final String appBarTitle;

  const CustomAppBarBack({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          Get.back();
        },
        color: tColorPrimary,
      ),
      toolbarHeight: tSizesBarAppHeight,
      elevation: 0,
      backgroundColor: tColorWhite,
      titleSpacing: 0,
      title: Text(
        appBarTitle,
        style: tStyleStandardAppBar,
      ),
    );
  }
}

//APPBAR
class CustomAppBarBackTraining extends StatelessWidget {
  const CustomAppBarBackTraining({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(
          Icons.clear,
          color: tColorWhite,
        ),
        onPressed: () {
          Get.back();
        },
        color: tColorPrimary,
      ),
      toolbarHeight: tSizesBarAppHeight,
      elevation: 0,
      backgroundColor: tColorBottomSheet,
      titleSpacing: 0,
    );
  }
}

//APPBAR
class CustomAppBarBackground extends StatelessWidget {
  final String appBarTitle;

  const CustomAppBarBackground({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          Get.back();
        },
        color: tColorWhite,
      ),
      toolbarHeight: tSizesBarAppHeight,
      elevation: 0,
      backgroundColor: tColorPrimary,
      titleSpacing: 0,
      title: Text(
        appBarTitle,
        style: tStyleStandardAppBarBg,
      ),
    );
  }
}

//APPBAR
class CustomAppBarBigTitle extends StatelessWidget {
  final String appBarTitle;
  final bool showBar;

  const CustomAppBarBigTitle({
    super.key,
    required this.appBarTitle,
    required this.showBar,
  });

  @override
  Widget build(BuildContext context) {
    if (showBar == true) {
      return AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        titleSpacing: tSizesMargin + 10,
        toolbarHeight: 120,
        backgroundColor: tColorBottomSheet,
        title: Text(
          appBarTitle,
          style: tStyleBigTitle,
        ),
      );
    } else {
      return const Text('');
    }
  }
}

class CustomAppBarBigTitleDash extends StatelessWidget {
  final String appBarTitle;
  final Widget avatar;

  const CustomAppBarBigTitleDash(
      {super.key, required this.appBarTitle, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      elevation: 0,
      titleSpacing: 20,
      toolbarHeight: 120,
      backgroundColor: tColorBottomSheet,
      title: Text(
        appBarTitle,
        style: tStyleBigTitle,
      ),
      actions: [avatar],
    );
  }
}

//APPBAR EXERCISE:
class CustomAppBarBackExerciseTimer extends StatelessWidget {
  final String appBarTitle;
  final ExerciseModel exerciseModel;
  final ExercisesController exercisesController;
  final BuildContext context;
  final ProvisionalExercisesSession provisionalExercisesSession;
  final ProvisionalTimerRecordsModel provisionalTimerRecordsModel;

  final TrainingController trainingController = Get.put(TrainingController());
  final RecordsController recordsController = Get.put(RecordsController());

  CustomAppBarBackExerciseTimer({
    super.key,
    required this.appBarTitle,
    required this.exerciseModel,
    required this.exercisesController,
    required this.context,
    required this.provisionalExercisesSession,
    required this.provisionalTimerRecordsModel,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          recordsController.saveProvisionalTimerRecordsModel(
              provisionalTimerRecordsModel: provisionalTimerRecordsModel);

          Get.to(() => TrainingSessionScreen(
              exercisesSession: provisionalExercisesSession,
              trainingModel: trainingController.getTrainingModel(
                  trainingId: exerciseModel.trainingId)));
        },
        color: tColorWhite,
      ),
      toolbarHeight: tSizesBarAppHeight,
      elevation: 0,
      backgroundColor: tColorBottomSheet,
      titleSpacing: 0,
      title: Text(
        appBarTitle,
        style: tStyleStandardAppBarBg,
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomAppBarBackExerciseRep extends StatelessWidget {
  final String appBarTitle;
  final ExerciseModel exerciseModel;
  final ExercisesController exercisesController;
  final BuildContext context;
  final ProvisionalExercisesSession provisionalExercisesSession;

  ProvisionalRepRecordsModel provisionalRepRecordsModel;

  final TrainingController trainingController = Get.put(TrainingController());
  final RecordsController recordsController = Get.put(RecordsController());

  CustomAppBarBackExerciseRep({
    super.key,
    required this.appBarTitle,
    required this.exerciseModel,
    required this.exercisesController,
    required this.context,
    required this.provisionalExercisesSession,
    required this.provisionalRepRecordsModel,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          recordsController.saveProvisionalRepRecordsModel(
              provisionalRepRecordsModel: provisionalRepRecordsModel);

          Get.to(() => TrainingSessionScreen(
              exercisesSession: provisionalExercisesSession,
              trainingModel: trainingController.getTrainingModel(
                  trainingId: exerciseModel.trainingId)));
        },
        color: tColorWhite,
      ),
      toolbarHeight: tSizesBarAppHeight,
      elevation: 0,
      backgroundColor: tColorBottomSheet,
      titleSpacing: 0,
      title: Text(
        appBarTitle,
        style: tStyleStandardAppBarBg,
      ),
    );
  }
}

class CustomAppBarBackExerciseT extends StatelessWidget {
  final String appBarTitle;
  final ExerciseModel exerciseModel;
  final ExercisesController exercisesController;
  final BuildContext context;
  final Color backColor;

  const CustomAppBarBackExerciseT(
      {super.key,
      required this.appBarTitle,
      required this.exerciseModel,
      required this.exercisesController,
      required this.context,
      required this.backColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          Get.back();
        },
        color: tColorWhite,
      ),
      toolbarHeight: tSizesBarAppHeight,
      elevation: 0,
      backgroundColor: backColor,
      titleSpacing: 0,
      title: Text(
        appBarTitle,
        style: tStyleStandardAppBarBg,
      ),
    );
  }
}
