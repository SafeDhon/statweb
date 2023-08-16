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

  // input parameter
  final inputX1 = TextEditingController();
  final inputX2 = TextEditingController();
  final inputn1 = TextEditingController();
  final inputn2 = TextEditingController();
  final inputO1 = TextEditingController();
  final inputO2 = TextEditingController();
  final inputd0 = TextEditingController();
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
                controller: inputX1,
                paramWidget: r'\bar{X_1}',
                hintText: 'Input Something'),
            InputParameter(
                controller: inputX2,
                paramWidget: r'\bar{X_2}',
                hintText: 'Input Something'),
            InputParameter(
              controller: inputn1,
              paramWidget: r'n_1',
              hintText: 'n = 1,2,3,...',
            ),
            InputParameter(
              controller: inputn2,
              paramWidget: r'n_2',
              hintText: 'n = 1,2,3,...',
            ),
            InputParameter(
              controller: inputO1,
              paramWidget: r'\sigma_1^2',
              hintText: 'Input Something',
            ),
            InputParameter(
              controller: inputO2,
              paramWidget: r'\sigma_2^2',
              hintText: 'Input Something',
            ),
            InputParameter(
              controller: inputd0,
              paramWidget: r'd_0',
              hintText: 'Input Something',
            ),
            calBox(
              () {
                setState(() {
                  onCal = true;
                });
                getAnswer().then((value) {
                  setState(() {
                    onCal = false;
                  });
                });
              },
              onCal,
            ),
            InputParameter(
              controller: TextEditingController(),
              paramWidget: r'f(x)',
              hintText: Z == 0.0 ? 'Please Input Parameter' : Z.toString(),
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getAnswer() async {
    var x1 = double.parse(inputX1.text);
    var x2 = double.parse(inputX2.text);
    var n1 = double.parse(inputn1.text);
    var n2 = double.parse(inputn2.text);
    var o1 = double.parse(inputO1.text);
    var o2 = double.parse(inputO2.text);
    var d0 = double.parse(inputd0.text);
    Z = ((x1 - x2) - d0) /
                    (pow((o1 * o1 / n1) + (o2 * o2 / n2), 1 / 2));
  }
}
