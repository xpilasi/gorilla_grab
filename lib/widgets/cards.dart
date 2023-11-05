import 'package:flutter/material.dart';

class CardTraining extends StatelessWidget {
  final String imageUrl;
  final String? titleImage;
  final void Function()? onPressed;
  const CardTraining(
      {super.key, required this.imageUrl, this.titleImage, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(children: [
        FadeInImage(
          image: AssetImage(imageUrl),
          placeholder: const AssetImage('images/jar-loading.gif'),
          width: double.infinity,
          height: 250,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 100),
        ),
        if (titleImage != null)
          Container(
              alignment: AlignmentDirectional.centerEnd,
              padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
              child: Text(titleImage!))
      ]),
    );
  }
}
