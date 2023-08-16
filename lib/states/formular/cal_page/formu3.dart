import 'dart:math';

import 'package:flutter/material.dart';
import 'package:statweb/states/formular/head_formular.dart';
import 'package:statweb/states/formular/input_parameter.dart';

class Formular3 extends StatefulWidget {
  final String formu;

  const Formular3({
    Key? key,
    required this.formu,
  }) : super(key: key);

  @override
  State<Formular3> createState() => _Formular3State();
}

class _Formular3State extends State<Formular3> {
  bool onCal = false;

  // input parameter
  final inputn = TextEditingController();
  final inputx = TextEditingController();
  final inputp = TextEditingController();
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
                controller: inputn,
                paramWidget: r'n',
                hintText: 'n = 1,2,3,...'),
            InputParameter(
                controller: inputx,
                paramWidget: r'x',
                hintText: 'x = 0,1,2,...,n'),
            InputParameter(
              controller: inputp,
              paramWidget: r'p',
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
              hintText: fx == 0.0 ? 'Please Input Parameter' : fx.toString(),
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getAnswer() async {
    var n = int.parse(inputn.text);
    var x = int.parse(inputx.text);
    var p = double.parse(inputp.text);
    fx = (fac(n) / ((n - fac(x)) * fac(x))) *
                    pow(p, x) *
                    pow(1 - p, n - x);
  }
}