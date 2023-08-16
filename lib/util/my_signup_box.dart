import 'package:flutter/material.dart';

class SignupBox extends StatelessWidget {

  final void Function()? onPressed;

  const SignupBox({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 50,
          width: double.maxFinite,
          color: Colors.purple,
          child: TextButton(
            onPressed: onPressed,
            child: const Text(
              'CREATE ACCOUNT',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
