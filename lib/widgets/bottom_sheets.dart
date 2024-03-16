import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/texts.dart';
import 'package:gorilla_grab/widgets/buttons.dart';

class BottomSheetContentDelete
 extends StatelessWidget {

  final String object;
  final void Function()? onPressedOk;
   // ignore: prefer_const_constructors_in_immutables
   BottomSheetContentDelete
  ({super.key, required this.object, this.onPressedOk});

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
                            onPressed: ()=>Get.back()),
                            
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

class BottomSheetSaveSession extends StatelessWidget {

  final TextEditingController commentController = TextEditingController();
  final void Function()? onPressed;
   BottomSheetSaveSession({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      //Main text
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Column(
                          children: [
                            const Text(
                              tTextCloseConfirmationSession,
                              softWrap: true,
                              style: tStyleBottomSheetSmaller,
                            ),

                            //Warning message:
                             Container(
                              height: 60,
                              child: 
                                const ListTile(
                                        leading: Icon(Icons.warning,color:tColorPinky),
                                        title: Text(
                                    tTextCloseConfirmationSessionAd,
                                    style: tStyleBottomSheetHighlighted,
                                    
                                  ),
                                      ),
                            ),
                          ],
                        ),
                      ),

        
                      //Session Comment
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                            color: tColorBottomSheetG,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          style: tStyleBottomSheetComment,
                          controller: commentController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            hintText: 'Add any final comment here.',
                            hintStyle: tStyleBottomSheetCommentHint,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      //Buttons
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButtonBottomCancel(
                                heigh: 50,
                                width: 160,
                                text: tTextCancel,
                                onPressed: ()=> Get.back()
                            ),

                            CustomButtonBottomSheet(
                                heigh: 50,
                                width: 160,
                                text: tButtonSaveSession,
                                onPressed: onPressed)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
  }
}