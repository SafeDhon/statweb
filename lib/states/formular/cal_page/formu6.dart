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

  // input parameter
  final inputu = TextEditingController();
  final inputx = TextEditingController();
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
                hintText: 'Input Something'),
            InputParameter(
              controller: inputx,
              paramWidget: r'x',
              hintText: 'x = 0,1,2,...',
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
              hintText: fx == 0.0 ? 'Please Input Parameter' : fx.toString(),
              readOnly: true,
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
  }
}
