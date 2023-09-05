import 'package:flutter/material.dart';
import 'package:statweb/my_icons_icons.dart';

import 'package:statweb/util/login_dialog.dart';

import '../constants.dart';

class MyHeader extends StatelessWidget {
  final String user_name;

  const MyHeader({
    Key? key,
    required this.user_name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            user_name,
            style: enFont('semibold', 18, metallicBlue),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: metallicBlue,
            borderRadius: BorderRadius.circular(60),
          ),
          child: const Icon(
            MyIcons.user1,
            color: Colors.white,
            size: 27,
          ),
        ),
      ],
    );
  }
}
