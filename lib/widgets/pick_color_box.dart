import 'package:flutter/material.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/widgets/color_picker.dart';

class PickUpColorBox extends StatelessWidget {
  const PickUpColorBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: tSizesMargin),
      child: Column(
        children: [
          const Text(
            'Pick up a color',
            style: tStyleInputLabel,
          ),
          const SizedBox(
            height: tSizesMargin,
          ),
          Container(
            width: 300,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ColorToPickUp(
                    colorToPickUp: tColorPink,
                    onPressed: () {
                      print('primer color');
                    },
                  ),
                  ColorToPickUp(
                    colorToPickUp: tColorGreeny,
                    onPressed: () {},
                  ),
                  ColorToPickUp(
                    colorToPickUp: tColorPrimary_6,
                    onPressed: () {},
                  ),
                  ColorToPickUp(
                    colorToPickUp: tColorPrimary,
                    onPressed: () {},
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
