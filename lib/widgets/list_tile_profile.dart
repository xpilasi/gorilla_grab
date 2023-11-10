import 'package:flutter/material.dart';
import 'package:gorilla_grab/constants/text_styles.dart';

import '../constants/colors.dart';

class ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? editInfo;
  const ProfileListTile({
    super.key,
    required this.icon,
    required this.title,
    this.editInfo,
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
      trailing: IconButton(
        icon: const Icon(Icons.arrow_forward_ios),
        iconSize: 15,
        color: tColorPinky,
        onPressed: editInfo,
      ),
    );
  }
}
