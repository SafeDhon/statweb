import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:statweb/states/formular/head_formular.dart';
import 'package:statweb/states/formular/input_parameter.dart';

class Formular4 extends StatefulWidget {
  final String formu;

  const Formular4({
    Key? key,
    required this.formu,
  }) : super(key: key);

  @override
  State<Formular4> createState() => _Formular4State();
}

class _Formular4State extends State<Formular4> {
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
                hintText: 'n = 0,1,2,...'),
            InputParameter(
                controller: inputx,
                paramWidget: r'x',
                hintText: 'example 1,2,3,...'),
            InputParameter(
              controller: inputp,
              paramWidget: r'p',
              hintText: 'example 1,2,3,...',
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
    var xlist = json.decode('[$inputx]');
    var plist = json.decode('[$inputp]');
    // double fx = 0;
    double xx = 1;
    double pp = 1;
    int countx = 0;
    for (var x in xlist) {
      xx = xx * fac(x);
    }
    for (var p in plist) {
      pp = pp * pow(p, xlist[countx]);
      countx = countx + 1;
    }
    fx = fac(n) * pp / xx;
  }
}
