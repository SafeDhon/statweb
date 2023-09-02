import 'dart:math';

import 'package:flutter/material.dart';
import 'package:statweb/states/formular/head_formular.dart';
import 'package:statweb/states/formular/input_parameter.dart';

class Formular13 extends StatefulWidget {
  final String formu;

  const Formular13({
    Key? key,
    required this.formu,
  }) : super(key: key);

  @override
  State<Formular13> createState() => _Formular13State();
}

class _Formular13State extends State<Formular13> {
  bool onCal = false;
  bool onCalHint = false;

  // input parameter
  final inputx1 = TextEditingController();
  final inputx2 = TextEditingController();
  final inputs1 = TextEditingController();
  final inputs2 = TextEditingController();
  final inputn1 = TextEditingController();
  final inputn2 = TextEditingController();
  final inputd0 = TextEditingController();
  bool wrongx1 = false;
  bool wrongx2 = false;
  bool wrongs1 = false;
  bool wrongs2 = false;
  bool wrongn1 = false;
  bool wrongn2 = false;
  bool wrongd0 = false;
  double t = 0.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            headFormular(widget.formu, context),
            InputParameter(
              controller: inputx1,
              paramWidget: r'\bar{X_1}',
              hintText: 'Input Something',
              wrongParam: wrongx1,
            ),
            InputParameter(
              controller: inputx2,
              paramWidget: r'\bar{X_2}',
              hintText: 'Input Something',
              wrongParam: wrongx2,
            ),
            InputParameter(
              controller: inputs1,
              paramWidget: r'S_1',
              hintText: 'Input Something',
              wrongParam: wrongs1,
            ),
            InputParameter(
              controller: inputs2,
              paramWidget: r'S_2',
              hintText: 'Input Something',
              wrongParam: wrongs2,
            ),
            InputParameter(
              controller: inputn1,
              paramWidget: r'n_1',
              hintText: 'n = 1,2,...,29',
              wrongParam: wrongn1,
            ),
            InputParameter(
              controller: inputn2,
              paramWidget: r'n_2',
              hintText: 'n = 1,2,...,29',
              wrongParam: wrongn2,
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
                  wrongx1 = false;
                  wrongx2 = false;
                  wrongs1 = false;
                  wrongs2 = false;
                  wrongn1 = false;
                  wrongn2 = false;
                  wrongd0 = false;
                });
                checkParam().then((value) {
                  onCal = false;
                  if (!wrongx1 &&
                      !wrongx2 &&
                      !wrongs1 &&
                      !wrongs2 &&
                      !wrongn1 &&
                      !wrongn2 &&
                      !wrongd0) {
                    onCal = true;
                    getAnswer().then((value) {
                      setState(() {
                        onCal = false;
                        wrongx1 = false;
                        wrongx2 = false;
                        wrongs1 = false;
                        wrongs2 = false;
                        wrongn1 = false;
                        wrongn2 = false;
                        wrongd0 = false;
                      });
                    });
                  }
                });
              },
              onCal,
            ),
            InputParameter(
              controller: TextEditingController(),
              paramWidget: r't',
              hintText: t == 0.0 ? 'Please Input Parameter' : t.toString(),
              readOnly: true,
              onCalHint: onCalHint,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getAnswer() async {
    var x1 = double.parse(inputx1.text);
    var x2 = double.parse(inputx2.text);
    var s1 = double.parse(inputs1.text);
    var s2 = double.parse(inputs2.text);
    var n1 = int.parse(inputn1.text);
    var n2 = int.parse(inputn2.text);
    var d0 = double.parse(inputd0.text);
    t = ((x1 - x2) - d0) / (pow((s1 * s1 / n1) + (s2 * s2 / n2), 1 / 2));
    setState(() => onCalHint = true);
  }

  Future<void> checkParam() async {
    if (inputx1.text == '') {
      setState(() => wrongx1 = true);
    } else {
      try {
        double.parse(inputx1.text);
      } catch (e) {
        setState(() => wrongx1 = true);
      }
    }
    if (inputx2.text == '') {
      setState(() => wrongx2 = true);
    } else {
      try {
        double.parse(inputx2.text);
      } catch (e) {
        setState(() => wrongx2 = true);
      }
    }
    if (inputs1.text == '') {
      setState(() => wrongs1 = true);
    } else {
      try {
        double.parse(inputs1.text);
      } catch (e) {
        setState(() => wrongs1 = true);
      }
    }
    if (inputs2.text == '') {
      setState(() => wrongs2 = true);
    } else {
      try {
        double.parse(inputs2.text);
      } catch (e) {
        setState(() => wrongs2 = true);
      }
    }
    if (inputn1.text == '') {
      setState(() => wrongn1 = true);
    } else {
      try {
        int n1 = int.parse(inputn1.text);
        if (n1 > 29 || n1 < 1) {
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
        if (n2 > 29 || n2 < 1) {
          setState(() => wrongn2 = true);
        }
      } catch (e) {
        setState(() => wrongn2 = true);
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
