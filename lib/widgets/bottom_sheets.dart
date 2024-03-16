import 'package:flutter/material.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/texts.dart';
import 'package:gorilla_grab/widgets/buttons.dart';

class BottomSheetContentDelete
 extends StatelessWidget {

  final String object;
  final void Function()? onPressedCancel;
  final void Function()? onPressedOk;
   // ignore: prefer_const_constructors_in_immutables
   BottomSheetContentDelete
  ({super.key, required this.object,this.onPressedCancel, this.onPressedOk});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
            
            
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0, right: 30, left: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: Text(
                      'Do you want to delete this $object?',
                      style: tStyleBottomSheet,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButtonBottomCancel(
                            heigh: 50,
                            width: 160,
                            text: tTextCancel,
                            onPressed: onPressedCancel),
                            
                        CustomButtonBottomSheet(
                            heigh: 50,
                            width: 160,
                            text: tTextDelete,
                            onPressed: onPressedOk)
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}