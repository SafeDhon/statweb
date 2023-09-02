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
              hintText: 'n = 0,1,2,...',
              wrongParam: wrongn,
            ),
            InputParameter(
              controller: inputx,
              paramWidget: r'x',
              hintText: 'x,x,...,x',
              wrongParam: wrongx,
            ),
            InputParameter(
              controller: inputp,
              paramWidget: r'p',
              hintText: 'p,p,...,p',
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
    var xlist = json.decode('[${inputx.text}]');
    var plist = json.decode('[${inputp.text}]');
    // double fx = 0;
    double xx = 1;
    double pp = 1;
    int countx = 0;
    for (var x in xlist) {
      x = double.parse(x.toString());
      xx = xx * fac(x);
    }
    for (var p in plist) {
      p = double.parse(p.toString());
      pp = pp * pow(p, xlist[countx]);
      countx = countx + 1;
    }
    fx = fac(n) * pp / xx;
    setState(() => onCalHint = true);
  }

  Future<void> checkParam() async {
    if (inputn.text == '') {
      setState(() => wrongn = true);
    } else {
      try {
        int n = int.parse(inputn.text);
        if (n < 0) {
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
        var xlist = json.decode('[${inputx.text}]');
        for (var x in xlist) {
          try {
            double.parse(x.toString());
          } catch (e) {
            setState(() => wrongx = true);
          }
        }
      } catch (e) {
        setState(() => wrongx = true);
      }
    }
    if (inputp.text == '') {
      setState(() => wrongp = true);
    } else {
      try {
        var plist = json.decode('[${inputp.text}]');
        for (var p in plist) {
          try {
            double.parse(p.toString());
          } catch (e) {
            setState(() => wrongp = true);
          }
        }
      } catch (e) {
        setState(() => wrongp = true);
      }
    }

    try {
      var xlist = json.decode('[${inputx.text}]');
      try {
        var plist = json.decode('[${inputp.text}]');
        if (plist.length != xlist.length) {
          setState(() {
            wrongx = true;
            wrongp = true;
          });
        }
      } catch (e) {
        setState(() => wrongp = true);
      }
    } catch (e) {
      setState(() => wrongx = true);
    }
  }
}
