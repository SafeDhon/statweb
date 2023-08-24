import 'dart:math';

import 'package:flutter/material.dart';
import 'package:statweb/states/formular/head_formular.dart';
import 'package:statweb/states/formular/input_parameter.dart';

class Formular8 extends StatefulWidget {
  final String formu;

  const Formular8({
    Key? key,
    required this.formu,
  }) : super(key: key);

  @override
  State<Formular8> createState() => _Formular8State();
}

class _Formular8State extends State<Formular8> {
  bool onCal = false;
  bool onCalHint = false;

  // input parameter
  final inputX = TextEditingController();
  final inputu = TextEditingController();
  final inputS = TextEditingController();
  final inputn = TextEditingController();
  bool wrongX = false;
  bool wrongu = false;
  bool wrongS = false;
  bool wrongn = false;
  double Z = 0.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            headFormular(widget.formu),
            InputParameter(
              controller: inputX,
              paramWidget: r'\bar{X}',
              hintText: 'Input Something',
              wrongParam: wrongX,
            ),
            InputParameter(
              controller: inputu,
              paramWidget: r'\mu',
              hintText: 'Input Something',
              wrongParam: wrongu,
            ),
            InputParameter(
              controller: inputS,
              paramWidget: r'S',
              hintText: 'Input Something',
              wrongParam: wrongS,
            ),
            InputParameter(
              controller: inputn,
              paramWidget: r'n',
              hintText: 'n = 30,31,32,...',
              wrongParam: wrongn,
            ),
            calBox(
              () {
                setState(() {
                  onCal = true;
                  wrongX = false;
                  wrongu = false;
                  wrongS = false;
                  wrongn = false;
                });
                checkParam().then((value) {
                  onCal = false;
                  if (!wrongX && !wrongu && !wrongS && !wrongn) {
                    onCal = true;
                    getAnswer().then((value) {
                      setState(() {
                        onCal = false;
                        wrongX = false;
                        wrongu = false;
                        wrongS = false;
                        wrongn = false;
                      });
                    });
                  }
                });
              },
              onCal,
            ),
            InputParameter(
              controller: TextEditingController(),
              paramWidget: r'Z',
              hintText: Z == 0.0 ? 'Please Input Parameter' : Z.toString(),
              readOnly: true,
              onCalHint: onCalHint,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getAnswer() async {
    var X = double.parse(inputX.text);
    var u = double.parse(inputu.text);
    var S = double.parse(inputS.text);
    var n = int.parse(inputn.text);
    Z = (X - u) / (S / (pow(n, 1 / 2)));
    setState(() => onCalHint = true);
  }

  Future<void> checkParam() async {
    if (inputX.text == '') {
      setState(() => wrongX = true);
    } else {
      try {
        double.parse(inputX.text);
      } catch (e) {
        setState(() => wrongX = true);
      }
    }
    if (inputu.text == '') {
      setState(() => wrongu = true);
    } else {
      try {
        double.parse(inputu.text);
      } catch (e) {
        setState(() => wrongu = true);
      }
    }
    if (inputS.text == '') {
      setState(() => wrongS = true);
    } else {
      try {
        double.parse(inputS.text);
      } catch (e) {
        setState(() => wrongS = true);
      }
    }
    if (inputn.text == '') {
      setState(() => wrongn = true);
    } else {
      try {
        int n = int.parse(inputn.text);
        if ( n < 30 ) {
          setState(() => wrongn = true);
        }
      } catch (e) {
        setState(() => wrongn = true);
      }
    }
  }
}
