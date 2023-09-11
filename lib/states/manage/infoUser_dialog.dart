import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:statweb/constants.dart';

class InfoUserDialog extends StatefulWidget {
  const InfoUserDialog({super.key});

  @override
  State<InfoUserDialog> createState() => _InfoUserDialogState();
}

class _InfoUserDialogState extends State<InfoUserDialog> {
  // String addID = '';
  // String addName = '';
  // String addSurname = '';
  // String addPassword = '';
  // String addConfirmPassword = '';
  bool onCreate = false;
  bool onError = false;
  String errorText = '';
  bool wrongID = false;
  bool wrongName = false;
  bool wrongSurname = false;
  bool wrongPassword = false;
  bool wrongConfirmPassword = false;

  TextEditingController controllerID = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerSurname = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: SizedBox(
        width: 280,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Text(
                    "Create User",
                    style: enFont('bold', 25, metallicBlue),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                inputInfo('Student ID', controllerID, wrongID),
                inputInfo('Name', controllerName, wrongName),
                inputInfo('Surname', controllerSurname, wrongSurname),
                inputInfo('Password', controllerPassword, wrongPassword),
                inputInfo('Confirm Password', controllerConfirmPassword,
                    wrongConfirmPassword),
                createUserButt(),
                onError
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(errorText,
                            style: enFont('semibold', 12, Colors.red)),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputInfo(
      String labelText, TextEditingController? controller, bool check) {
    return SizedBox(
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 1.0),
                child: TextField(
                  controller: controller,
                  textAlignVertical: TextAlignVertical.bottom,
                  // textAlign: TextAlign.center,
                  style: enFont('bold', 15, metallicBlue),
                  onChanged: (value) {},
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: labelText,
                    labelStyle:
                        enFont('bold', 15, check ? Colors.red : metallicBlue),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 22.0),
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                            color: check ? Colors.red.shade400 : beauBlue,
                            width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: metallicBlue, width: 2)),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget createUserButt() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: () {
          setState(() {
            onError = false;
            errorText = '';
            wrongID = false;
            wrongName = false;
            wrongSurname = false;
            wrongPassword = false;
            wrongConfirmPassword = false;
          });
          if (controllerPassword.text != controllerConfirmPassword.text) {
            setState(() {
              wrongPassword = true;
              wrongConfirmPassword = true;
            });
          }
          if (controllerID.text.isEmpty) {
            setState(() => wrongID = true);
          }
          if (controllerName.text.isEmpty) {
            setState(() => wrongName = true);
          }
          if (controllerSurname.text.isEmpty) {
            setState(() => wrongSurname = true);
          }
          if (controllerPassword.text.isEmpty) {
            setState(() => wrongPassword = true);
          }
          if (controllerConfirmPassword.text.isEmpty) {
            setState(() => wrongConfirmPassword = true);
          }
          if (!wrongID &&
              !wrongName &&
              !wrongSurname &&
              !wrongPassword &&
              !wrongConfirmPassword) {
            setState(() => onCreate = true);
            addUserToFirebase(
              controllerID.text,
              controllerName.text,
              controllerSurname.text,
              controllerPassword.text,
            ).then((value) {
              Navigator.pop(context);
            });
          }
        },
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: metallicBlue,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Center(
            child: onCreate
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Create',
                        style: enFont('bold', 18, Colors.white),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> addUserToFirebase(
      String id, String name, String surname, String password) async {
    var data = {
      "name": name,
      "surname": surname,
      "password": password,
      "section": "IEA",
      "year": "2",
      "typeuser": "student",
    };
    try {
      UserCredential? result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: '$id@gmail.com', password: password)
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(id)
            .set(data)
            .then((value) {
          setState(() => onCreate = false);
        }).catchError((error) {
          setState(() {
            onError = true;
            errorText = error.toString();
            onCreate = false;
          });
        });
      }).catchError((error) {
        setState(() {
          onError = true;
          errorText = error.toString();
          onCreate = false;
        });
      });

      await FirebaseAuth.instance.currentUser!.updateDisplayName(id);
      // User? user = result!.user;
      // await user?.updateDisplayName(id);
      // ลบ user ใน auth
      // เพิ่มตาราง score
    } catch (e) {
      setState(() {
        onError = true;
        errorText = e.toString();
        onCreate = false;
      });
    }
  }
}
