import 'package:flutter/material.dart';
import 'package:gorilla_grab/constants/colors.dart';

import '../constants/text_styles.dart';

class ExerciseRecord extends StatelessWidget {
  final String exerciseRecord;
  final String exerciseName;

  const ExerciseRecord({
    super.key,
    required this.exerciseRecord,
    required this.exerciseName,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [tColorPrimary_5, tColorPrimary_5],
        ).createShader(bounds);
      },
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              exerciseRecord,
              style: tStyleDashBoardRecord,
            ),
            Text(
              exerciseName,
              //dashBoardController.exerciseOptions[index],
              style: tStyleDashBoardExercise,
            ),
          ],
        ),
      ),
    );
  }
}
