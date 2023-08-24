// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';

class UpdateScoreDialog extends StatefulWidget {
  final String userID;
  final String header;
  final String quiz1;
  final String quiz2;
  final String midterm;
  final String finalterm;
  final String total;

  const UpdateScoreDialog({
    Key? key,
    required this.userID,
    required this.header,
    required this.quiz1,
    required this.quiz2,
    required this.midterm,
    required this.finalterm,
    required this.total,
  }) : super(key: key);

  @override
  State<UpdateScoreDialog> createState() => _UpdateScoreDialogState();
}

class _UpdateScoreDialogState extends State<UpdateScoreDialog> {
  bool onUpdate = false;
  String updateQuiz1 = '';
  String updateQuiz2 = '';
  String updateMidterm = '';
  String updateFinal = '';
  String updateTotal = '';

  @override
  void initState() {
    super.initState();
    updateQuiz1 = widget.quiz1;
    updateQuiz2 = widget.quiz2;
    updateMidterm = widget.midterm;
    updateFinal = widget.finalterm;
    updateTotal = widget.total;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: SizedBox(
        width: 250,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Column(
              children: [
                scoreHeader(widget.header),
                inputScore('Quiz 1', widget.quiz1),
                inputScore('Midterm', widget.midterm),
                inputScore('Quiz 2', widget.quiz2),
                inputScore('Final', widget.finalterm),
                inputScore('Total', widget.total),
                updateButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputScore(String labelText, String oldScore) {
    // TextEditingController controller = TextEditingController();
    return SizedBox(
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: TextField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                  ],

                  // readOnly: readOnly,
                  textAlignVertical: TextAlignVertical.bottom,
                  // textAlign: TextAlign.center,
                  style: enFont('bold', 15, metallicBlue),
                  onChanged: (value) {
                    switch (labelText) {
                      case 'Quiz 1':
                        if (value.isEmpty) {
                          setState(() => updateQuiz1 = widget.quiz1);
                        } else {
                          setState(() => updateQuiz1 = value.toString());
                        }
                        break;
                      case 'Midterm':
                        if (value.isEmpty) {
                          setState(() => updateMidterm = widget.midterm);
                        } else {
                          setState(() => updateMidterm = value.toString());
                        }
                        break;
                      case 'Quiz 2':
                        if (value.isEmpty) {
                          setState(() => updateQuiz2 = widget.quiz2);
                        } else {
                          setState(() => updateQuiz2 = value.toString());
                        }
                        break;
                      case 'Final':
                        if (value.isEmpty) {
                          setState(() => updateFinal = widget.finalterm);
                        } else {
                          setState(() => updateFinal = value.toString());
                        }
                        break;
                      case 'Total':
                        if (value.isEmpty) {
                          setState(() => updateTotal = widget.total);
                        } else {
                          setState(() => updateTotal = value.toString());
                        }
                        break;
                    }
                  },
                  // controller: controller,

                  // keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: oldScore,
                    labelText: labelText,
                    labelStyle: enFont('bold', 15, metallicBlue),
                    hintStyle: enFont('bold', 15, beauBlue),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 22.0),
                    isDense: true,
                    // enabledBorder: ,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: beauBlue, width: 2)),
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

  Widget updateButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: InkWell(
        onTap: () {
          setState(() => onUpdate = true);
          updateToCloud(widget.userID)
              .then((value) => setState(() => onUpdate = false));
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: metallicBlue, borderRadius: BorderRadius.circular(18)),
          child: Center(
            child: onUpdate
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3.0,
                    ))
                : Text(
                    'Update',
                    style: enFont('bold', 18, Colors.white),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> updateToCloud(String userID) async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance.collection('score').doc(userID).update({
        'quiz1': updateQuiz1,
        'midterm': updateMidterm,
        'quiz2': updateQuiz2,
        'final': updateFinal,
        'total': updateTotal,
      }).then((value) {
        Navigator.pop(context);
      }).catchError((error) {});
    });
  }

  Widget scoreHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Text(
        text,
        style: enFont('semibold', 20, metallicBlue),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
