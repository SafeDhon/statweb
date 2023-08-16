import 'package:flutter/material.dart';

class SigninBox extends StatelessWidget {

  final void Function()? onPressed;

  const SigninBox({
    Key? key,
    required this.onPressed,
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
          color: Colors.green,
          child: TextButton(
            onPressed: onPressed,
            child: const Text(
              'LOGIN',
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
