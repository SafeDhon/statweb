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
  bool onCalHint = false;

  // input parameter
  final inputn = TextEditingController();
  final inputx = TextEditingController();
  final inputp = TextEditingController();
  bool wrongn = false;
  bool wrongx = false;
  bool wrongp = false;
  double fx = 0.0;

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
              controller: inputn,
              paramWidget: r'n',
              hintText: 'n = 1,2,3,...',
              wrongParam: wrongn,
            ),
            InputParameter(
              controller: inputx,
              paramWidget: r'x',
              hintText: 'x = 0,1,2,...,n',
              wrongParam: wrongx,
            ),
            InputParameter(
              controller: inputp,
              paramWidget: r'p',
              hintText: 'Input Something',
              wrongParam: wrongp,
            ),
            calBox(
              () {
                setState(() {
                  onCal = true;
                  wrongn = false;
                  wrongx = false;
                  wrongp = false;
                });
                checkParam().then((value) {
                  onCal = false;
                  if (!wrongn && !wrongx && !wrongp) {
                    onCal = true;
                    getAnswer().then((value) {
                      setState(() {
                        onCal = false;
                        wrongn = false;
                        wrongx = false;
                        wrongp = false;
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
    var n = int.parse(inputn.text);
    var x = int.parse(inputx.text);
    var p = double.parse(inputp.text);
    fx = nchoosex(n, x) * pow(p, x) * pow(1 - p, n - x);
    setState(() => onCalHint = true);
  }

  Future<void> checkParam() async {
    if (inputn.text == '') {
      setState(() => wrongn = true);
    } else {
      try {
        int n = int.parse(inputn.text);
        int x = int.parse(inputx.text);
        if (n <= x) {
          setState(() => wrongn = true);
        }
      } catch (e) {
        setState(() => wrongn = true);
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
    if (inputp.text == '') {
      setState(() => wrongp = true);
    } else {
      try {
        double.parse(inputp.text);
      } catch (e) {
        setState(() => wrongp = true);
      }
    }
  }
}
