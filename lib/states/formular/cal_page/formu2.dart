import 'package:flutter/material.dart';
import 'package:statweb/states/formular/head_formular.dart';
import 'package:statweb/states/formular/input_parameter.dart';

class Formular2 extends StatefulWidget {
  final String formu;

  const Formular2({
    Key? key,
    required this.formu,
  }) : super(key: key);

  @override
  State<Formular2> createState() => _Formular2State();
}

class _Formular2State extends State<Formular2> {
  bool onCal = false;
  bool onCalHint = false;

  // input parameter
  final inputp = TextEditingController();
  final inputq = TextEditingController();
  final inputx = TextEditingController();
  bool wrongp = false;
  bool wrongq = false;
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
              controller: inputp,
              paramWidget: r'p',
              hintText: 'Input Something',
              wrongParam: wrongp,
            ),
            InputParameter(
              controller: inputq,
              paramWidget: r'q',
              hintText: 'Input Something',
              wrongParam: wrongq,
            ),
            InputParameter(
              controller: inputx,
              paramWidget: r'x',
              hintText: 'x = 0,1',
              wrongParam: wrongx,
            ),
            calBox(
              () {
                setState(() {
                  onCal = true;
                  wrongp = false;
                  wrongq = false;
                  wrongx = false;
                });
                checkParam().then((value) {
                  onCal = false;
                  if (!wrongp && !wrongq && !wrongx) {
                    onCal = true;
                    getAnswer().then((value) {
                      setState(() {
                        onCal = false;
                        wrongp = false;
                        wrongq = false;
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
    var p = double.parse(inputp.text);
    var q = double.parse(inputq.text);
    var x = int.parse(inputx.text);
    fx = x == 0 ? q : p;
    setState(() => onCalHint = true);
  }

  Future<void> checkParam() async {
    if (inputp.text == '') {
      setState(() => wrongp = true);
    } else {
      try {
        double.parse(inputp.text);
      } catch (e) {
        setState(() => wrongp = true);
      }
    }
    if (inputq.text == '') {
      setState(() => wrongq = true);
    } else {
      try {
        double.parse(inputq.text);
      } catch (e) {
        setState(() => wrongq = true);
      }
    }
    if (inputx.text == '') {
      setState(() => wrongx = true);
    } else {
      try {
        int x = int.parse(inputx.text);
        if (x != 0 && x != 1) {
          setState(() => wrongx = true);
        }
      } catch (e) {
        setState(() => wrongx = true);
      }
    }
    try {
      double p = double.parse(inputp.text);
      try {
        double q = double.parse(inputq.text);
        if (q + p != 1) {
          setState(() {
            wrongq = true;
            wrongp = true;
          });
        }
      } catch (e) {
        setState(() => wrongq = true);
      }
    } catch (e) {
      setState(() => wrongp = true);
    }
  }
}
