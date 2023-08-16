import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:statweb/constants.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  bool isLoading = true;

  Future logout() async {
    print('Log Out');
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.signOut().then((value) => null);
    });
  }

  @override
  void initState() {
    super.initState();
    logout().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: 180,
          height: 120,
          child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : Text(
                    'Logged Out !!',
                    style: enFont('bold', 22, metallicBlue),
                  ),
          ),
        ));
  }
}
