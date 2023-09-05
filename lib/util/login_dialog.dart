import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statweb/constants.dart';
import 'package:statweb/my_icons_icons.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  bool isLoading = false;
  bool isError = false;
  bool emptyUser = false;
  bool emptyPassword = false;

  String user = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50,
              width: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: emptyUser ? Colors.red : metallicBlue,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  obscureText: false,
                  style: enFont('bold', 15, metallicBlue),
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(MyIcons.user1),
                    prefixIconColor: emptyUser ? Colors.red.shade300 : glaucous,
                    focusColor: metallicBlue,
                    hintText: 'Student ID',
                    hintStyle: enFont(
                        'bold', 15, emptyUser ? Colors.red.shade300 : glaucous),
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    isLoading = false;
                    isError = false;
                    user = val.trim();
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 50,
              width: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: emptyPassword ? Colors.red : metallicBlue,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  obscureText: true,
                  style: enFont('bold', 15, metallicBlue),
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(MyIcons.icons8_lock),
                    prefixIconColor:
                        emptyPassword ? Colors.red.shade300 : glaucous,
                    focusColor: metallicBlue,
                    hintText: 'Password',
                    hintStyle: enFont('bold', 15,
                        emptyPassword ? Colors.red.shade300 : glaucous),
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    setState(() {
                      isError = false;
                    });
                    password = val.trim();
                  },
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 270,
              height: 40,
              child: isLoading
                  ? myCircularLoading()
                  : isError
                      ? Center(
                          child: Text(
                            'Please try again',
                            style: enFont('bold', 15, Colors.red),
                          ),
                        )
                      : Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: metallicBlue,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Cancle',
                                    style: enFont('bold', 15, metallicBlue),
                                  )),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  if (user.isEmpty) {
                                    setState(() {
                                      emptyUser = true;
                                    });
                                  }
                                  if (password.isEmpty) {
                                    setState(() {
                                      emptyPassword = true;
                                    });
                                  }
                                  if (password.isNotEmpty && user.isNotEmpty) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: '$user@gmail.com',
                                            password: password)
                                        .then((value) async {
                                      User? user =
                                          FirebaseAuth.instance.currentUser;

                                      getUser(user!.displayName.toString())
                                          .then((value) {
                                        Navigator.pop(context);
                                      });
                                    }).catchError((e) {
                                      print(e);
                                      setState(() {
                                        emptyUser = true;
                                        emptyPassword = true;
                                        isLoading = false;
                                        isError = true;
                                      });
                                    });
                                  }

                                  // setState(() {
                                  //   // isLoading = true;
                                  //   emptyUser = true;
                                  //   print(user);
                                  //   print(password);
                                  // });
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: metallicBlue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Login',
                                      style: enFont('bold', 15, Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getUser(String user) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user)
        .get()
        .then((value) async {
      setPreferences(
        user,
        value['name'],
        value['surname'],
        value['typeuser'],
      ).then((value) {
        print('get user complete');
      });
    });
  }

  Future<void> setPreferences(
      String id, String name, String surname, String type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', id);
    preferences.setString('name', name);
    preferences.setString('surname', surname);
    preferences.setString('type', type);
  }
}
