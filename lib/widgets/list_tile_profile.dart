import 'package:flutter/material.dart';
import 'package:gorilla_grab/constants/text_styles.dart';

import '../constants/colors.dart';

class ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  const ProfileListTile({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
          icon,
          color: tColorPinky,
        ),
        title: Text(
          title,
          style: tStyleProfileText,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: tColorPinky,
        ));
  }
}
