import 'package:flutter/material.dart';

import '../constants.dart';
import 'login_dialog.dart';

class LoginTopButton extends StatefulWidget {
final Function()? onTap;

  const LoginTopButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<LoginTopButton> createState() => _LoginTopButtonState();
}

class _LoginTopButtonState extends State<LoginTopButton> {
  // bool isLoading = false;
  // bool emptyUser = false;
  // bool emptyPassword = false;

  // String user = '';
  // String password = '';

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // bool emptyUser = false;
  //   // bool emptyPassword = false;
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        // alignment: Alignment.centerRight,
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: metallicBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'Login',
            style: enFont('bold', 15, Colors.white),
          ),
        ),
      ),
    );
  }
}
