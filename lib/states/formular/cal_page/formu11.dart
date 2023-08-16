import 'dart:math';

import 'package:flutter/material.dart';
import 'package:statweb/states/formular/head_formular.dart';
import 'package:statweb/states/formular/input_parameter.dart';

class Formular11 extends StatefulWidget {
  final String formu;

  const Formular11({
    Key? key,
    required this.formu,
  }) : super(key: key);

  @override
  State<Formular11> createState() => _Formular11State();
}

class _Formular11State extends State<Formular11> {
  bool onCal = false;

  // input parameter
  final inputx1 = TextEditingController();
  final inputx2 = TextEditingController();
  final inputn1 = TextEditingController();
  final inputn2 = TextEditingController();
  final inputs1 = TextEditingController();
  final inputs2 = TextEditingController();
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
                controller: inputx1,
                paramWidget: r'\bar{X_1}',
                hintText: 'Input Something'),
            InputParameter(
                controller: inputx2,
                paramWidget: r'\bar{X_2}',
                hintText: 'Input Something'),
            InputParameter(
              controller: inputn2,
              paramWidget: r'n_1',
              hintText: 'n = 30,31,32,...',
            ),
            InputParameter(
              controller: inputn2,
              paramWidget: r'n_2',
              hintText: 'n = 30,31,32,...',
            ),
            InputParameter(
              controller: inputs1,
              paramWidget: r'S_1^2',
              hintText: 'Input Something',
            ),
            InputParameter(
              controller: inputs2,
              paramWidget: r'S_2^2',
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
              paramWidget: r'Z',
              hintText: Z == 0.0 ? 'Please Input Parameter' : Z.toString(),
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getAnswer() async {
    var x1 = double.parse(inputx1.text);
    var x2 = double.parse(inputx2.text);
    var n1 = double.parse(inputn1.text);
    var n2 = double.parse(inputn2.text);
    var s1 = double.parse(inputs1.text);
    var s2 = double.parse(inputs2.text);
    var d0 = double.parse(inputd0.text);
     Z = ((x1 - x2) - d0) /
                    (pow((s1 * s1 / n1) + (s2 * s2 / n2), 1 / 2));
  }
}
