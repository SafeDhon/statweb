import 'dart:math';

import 'package:flutter/material.dart';
import 'package:statweb/states/formular/head_formular.dart';
import 'package:statweb/states/formular/input_parameter.dart';

class Formular6 extends StatefulWidget {
  final String formu;

  const Formular6({
    Key? key,
    required this.formu,
  }) : super(key: key);

  @override
  State<Formular6> createState() => _Formular6State();
}

class _Formular6State extends State<Formular6> {
  bool onCal = false;
  bool onCalHint = false;

  // input parameter
  final inputu = TextEditingController();
  final inputx = TextEditingController();
  bool wrongu = false;
  bool wrongx = false;
  double fx = 0.0;

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
              controller: inputu,
              paramWidget: r'\mu',
              hintText: 'Input Something',
              wrongParam: wrongu,
            ),
            InputParameter(
              controller: inputx,
              paramWidget: r'x',
              hintText: 'x = 0,1,2,...',
              wrongParam: wrongx,
            ),
            calBox(
              () {
                setState(() {
                  onCal = true;
                  wrongu = false;
                  wrongx = false;
                });
                checkParam().then((value) {
                  onCal = false;
                  if (!wrongu && !wrongx) {
                    onCal = true;
                    getAnswer().then((value) {
                      setState(() {
                        onCal = false;
                        wrongu = false;
                        wrongx = false;
                      });
                    });
                  }
                });
              },
              onCal,
            ),
            InputParameter(
              controller: TextEditingController(),
              paramWidget: r'f(x)',
              hintText: fx == 0.0 ? 'Please Input Parameter' : fx.toString(),
              readOnly: true,
              onCalHint: onCalHint,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getAnswer() async {
    var u = double.parse(inputu.text);
    var x = int.parse(inputx.text);
    fx = (pow(e, -u) * pow(u, e)) / fac(x);
    setState(() => onCalHint = true);
  }
  
  Future<void> checkParam() async {
    if (inputu.text == '') {
      setState(() => wrongu = true);
    } else {
      try {
        double.parse(inputu.text);
      } catch (e) {
        setState(() => wrongu = true);
      }
    }
    if (inputx.text == '') {
      setState(() => wrongx = true);
    } else {
      try {
        int x = int.parse(inputx.text);
        if (x < 0) {
          setState(() => wrongx = true);
        }
      } catch (e) {
        setState(() => wrongx = true);
      }
    }
  }
}
