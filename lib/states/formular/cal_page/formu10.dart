import 'dart:math';

import 'package:flutter/material.dart';
import 'package:statweb/states/formular/head_formular.dart';
import 'package:statweb/states/formular/input_parameter.dart';

class Formular10 extends StatefulWidget {
  final String formu;

  const Formular10({
    Key? key,
    required this.formu,
  }) : super(key: key);

  @override
  State<Formular10> createState() => _Formular10State();
}

class _Formular10State extends State<Formular10> {
  bool onCal = false;
  bool onCalHint = false;

  // input parameter
  final inputX1 = TextEditingController();
  final inputX2 = TextEditingController();
  final inputn1 = TextEditingController();
  final inputn2 = TextEditingController();
  final inputO1 = TextEditingController();
  final inputO2 = TextEditingController();
  final inputd0 = TextEditingController();
  bool wrongX1 = false;
  bool wrongX2 = false;
  bool wrongn1 = false;
  bool wrongn2 = false;
  bool wrongO1 = false;
  bool wrongO2 = false;
  bool wrongd0 = false;
  double Z = 0.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            headFormular(widget.formu,context),
            InputParameter(
              controller: inputX1,
              paramWidget: r'\bar{X_1}',
              hintText: 'Input Something',
              wrongParam: wrongX1,
            ),
            InputParameter(
              controller: inputX2,
              paramWidget: r'\bar{X_2}',
              hintText: 'Input Something',
              wrongParam: wrongX2,
            ),
            InputParameter(
              controller: inputn1,
              paramWidget: r'n_1',
              hintText: 'n = 1,2,3,...',
              wrongParam: wrongn1,
            ),
            InputParameter(
              controller: inputn2,
              paramWidget: r'n_2',
              hintText: 'n = 1,2,3,...',
              wrongParam: wrongn2,
            ),
            InputParameter(
              controller: inputO1,
              paramWidget: r'\sigma_1',
              hintText: 'Input Something',
              wrongParam: wrongO1,
            ),
            InputParameter(
              controller: inputO2,
              paramWidget: r'\sigma_2',
              hintText: 'Input Something',
              wrongParam: wrongO2,
            ),
            InputParameter(
              controller: inputd0,
              paramWidget: r'd_0',
              hintText: 'Input Something',
              wrongParam: wrongd0,
            ),
            calBox(
              () {
                setState(() {
                  onCal = true;
                  wrongX1 = false;
                  wrongX2 = false;
                  wrongn1 = false;
                  wrongn2 = false;
                  wrongO1 = false;
                  wrongO2 = false;
                  wrongd0 = false;
                });
                checkParam().then((value) {
                  onCal = false;
                  if (!wrongX1 &&
                      !wrongX2 &&
                      !wrongn1 &&
                      !wrongn2 &&
                      !wrongO1 &&
                      !wrongO2 &&
                      !wrongd0) {
                    onCal = true;
                    getAnswer().then((value) {
                      setState(() {
                        onCal = false;
                        wrongX1 = false;
                        wrongX2 = false;
                        wrongn1 = false;
                        wrongn2 = false;
                        wrongO1 = false;
                        wrongO2 = false;
                        wrongd0 = false;
                      });
                    });
                  }
                });
              },
              onCal,context
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
    var x1 = double.parse(inputX1.text);
    var x2 = double.parse(inputX2.text);
    var n1 = int.parse(inputn1.text);
    var n2 = int.parse(inputn2.text);
    var o1 = double.parse(inputO1.text);
    var o2 = double.parse(inputO2.text);
    var d0 = double.parse(inputd0.text);
    Z = ((x1 - x2) - d0) / (pow((o1 * o1 / n1) + (o2 * o2 / n2), 1 / 2));
    setState(() => onCalHint = true);
  }

  Future<void> checkParam() async {
    if (inputX1.text == '') {
      setState(() => wrongX1 = true);
    } else {
      try {
        double.parse(inputX1.text);
      } catch (e) {
        setState(() => wrongX1 = true);
      }
    }
    if (inputX2.text == '') {
      setState(() => wrongX2 = true);
    } else {
      try {
        double.parse(inputX2.text);
      } catch (e) {
        setState(() => wrongX2 = true);
      }
    }
    if (inputn1.text == '') {
      setState(() => wrongn1 = true);
    } else {
      try {
        int n1 = int.parse(inputn1.text);
        if (n1 < 1) {
          setState(() => wrongn1 = true);
        }
      } catch (e) {
        setState(() => wrongn1 = true);
      }
    }
    if (inputn2.text == '') {
      setState(() => wrongn2 = true);
    } else {
      try {
        int n2 = int.parse(inputn1.text);
        if (n2 < 1) {
          setState(() => wrongn2 = true);
        }
      } catch (e) {
        setState(() => wrongn2 = true);
      }
    }
    if (inputO1.text == '') {
      setState(() => wrongO1 = true);
    } else {
      try {
        double.parse(inputO1.text);
      } catch (e) {
        setState(() => wrongO1 = true);
      }
    }
    if (inputO2.text == '') {
      setState(() => wrongO2 = true);
    } else {
      try {
        double.parse(inputO2.text);
      } catch (e) {
        setState(() => wrongO2 = true);
      }
    }
    if (inputd0.text == '') {
      setState(() => wrongd0 = true);
    } else {
      try {
        double.parse(inputd0.text);
      } catch (e) {
        setState(() => wrongd0 = true);
      }
    }
  }
}
