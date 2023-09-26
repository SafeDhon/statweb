import 'dart:math';

import 'package:flutter/material.dart';
import 'package:statweb/states/formular/head_formular.dart';
import 'package:statweb/states/formular/input_parameter.dart';

class Formular7 extends StatefulWidget {
  final String formu;

  const Formular7({
    Key? key,
    required this.formu,
  }) : super(key: key);

  @override
  State<Formular7> createState() => _Formular7State();
}

class _Formular7State extends State<Formular7> {
  bool onCal = false;
  bool onCalHint = false;

  // input parameter
  final inputX = TextEditingController();
  final inputu = TextEditingController();
  final inputO = TextEditingController();
  final inputn = TextEditingController();
  bool wrongX = false;
  bool wrongu = false;
  bool wrongO = false;
  bool wrongn = false;
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
              controller: inputO,
              paramWidget: r'\sigma',
              hintText: 'Input Something',
              wrongParam: wrongO,
            ),
            InputParameter(
              controller: inputn,
              paramWidget: r'n',
              hintText: 'n = 0,1,2,...',
              wrongParam: wrongn,
            ),
            calBox(
              () {
                setState(() {
                  onCal = true;
                  wrongX = false;
                  wrongu = false;
                  wrongO = false;
                  wrongn = false;
                });
                checkParam().then((value) {
                  onCal = false;
                  if (!wrongX && !wrongu && !wrongO && !wrongn) {
                    onCal = true;
                    getAnswer().then((value) {
                      setState(() {
                        onCal = false;
                        wrongX = false;
                        wrongu = false;
                        wrongO = false;
                        wrongn = false;
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
    var X = double.parse(inputX.text);
    var u = double.parse(inputu.text);
    var O = double.parse(inputO.text);
    var n = int.parse(inputn.text);
    Z = (X - u) / (O / (pow(n, 1 / 2)));
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
    if (inputO.text == '') {
      setState(() => wrongO = true);
    } else {
      try {
        double.parse(inputO.text);
      } catch (e) {
        setState(() => wrongO = true);
      }
    }
    if (inputn.text == '') {
      setState(() => wrongn = true);
    } else {
      try {
        int n = int.parse(inputn.text);
        if (n < 0 ) {
          setState(() => wrongn = true);
        }
      } catch (e) {
        setState(() => wrongn = true);
      }
    }
  }
}
