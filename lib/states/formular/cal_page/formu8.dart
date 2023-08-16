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

  // input parameter
  final inputX = TextEditingController();
  final inputu = TextEditingController();
  final inputS = TextEditingController();
  final inputn = TextEditingController();
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
                hintText: 'Input Something'),
            InputParameter(
                controller: inputu,
                paramWidget: r'\mu',
                hintText: 'Input Something'),
            InputParameter(
              controller: inputS,
              paramWidget: r'S',
              hintText: 'Input Something',
            ),
            InputParameter(
              controller: inputn,
              paramWidget: r'n',
              hintText: 'n = 30,31,32,...',
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
    var X = double.parse(inputX.text);
    var u = double.parse(inputu.text);
    var S = double.parse(inputS.text);
    var n = double.parse(inputn.text);
    Z = (X - u) / (S / (pow(n, 1 / 2)));
  }
}
