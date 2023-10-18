import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/controllers/stats_controller.dart';
import 'package:gorilla_grab/widgets/bar_graph/bar_graph.dart';
import 'package:gorilla_grab/widgets/headers.dart';
import 'package:gorilla_grab/widgets/titles.dart';

class StatsScreen extends StatelessWidget {
  final StatsController statsController = Get.put(StatsController());
  StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: allAppBackground,
        body: GetBuilder<StatsController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.only(
                  right: tSizesMargin, top: tSizesMargin, bottom: tSizesMargin),
              child: Stack(
                children: [
                  //Header
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                        //color: tColorGreen,
                        height: 100,
                        child: HeaderForMenu(title: 'Stats')),
                  ),

                  Positioned(
                      top: 100,
                      left: tSizesMargin,
                      right: 0,
                      child: Container(
                          decoration: BoxDecoration(
                            color: tColorBottomSheetG2,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          //color: tColorBottomSheetG),
                          height: 290,
                          child: const Padding(
                            padding: EdgeInsets.only(
                                bottom: 40.0, top: 90, left: 20, right: 20),
                            child: PerformancesBarGraph(),
                          ))),
                  //Chart title
                  Positioned(
                    top: 80,
                    //right: 20,
                    left: 20,
                    child: Container(
                        //color: tColorGreen,
                        height: 100,
                        child: TitleLeft(
                          title: 'Last Performances',
                        )),
                  ),
                  Positioned(
                    top: 110,
                    right: 20,
                    //left: 20,
                    child: Container(
                        decoration: BoxDecoration(
                            color: tColorBottomSheet,
                            borderRadius: BorderRadius.circular(30)),
                        height: 40,
                        child: const Center(
                          child: Row(
                            children: [
                              TitleLeft(
                                title: 'Sharma',
                              ),
                              Icon(
                                Icons.arrow_drop_down_rounded,
                                color: tColorWhite,
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
