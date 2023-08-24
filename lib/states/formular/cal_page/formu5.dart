import 'package:flutter/material.dart';
import 'package:statweb/states/formular/head_formular.dart';
import 'package:statweb/states/formular/input_parameter.dart';

class Formular5 extends StatefulWidget {
  final String formu;

  const Formular5({
    Key? key,
    required this.formu,
  }) : super(key: key);

  @override
  State<Formular5> createState() => _Formular5State();
}

class _Formular5State extends State<Formular5> {
  bool onCal = false;
  bool onCalHint = false;

  // input parameter
  final inputk = TextEditingController();
  final inputx = TextEditingController();
  final inputN = TextEditingController();
  final inputn = TextEditingController();
  bool wrongk = false;
  bool wrongx = false;
  bool wrongN = false;
  bool wrongn = false;
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
              controller: inputk,
              paramWidget: r'k',
              hintText: 'k = 1,2,3,...',
              wrongParam: wrongk,
            ),
            InputParameter(
              controller: inputx,
              paramWidget: r'x',
              hintText: 'x = 0,1,2,...,k',
              wrongParam: wrongx,
            ),
            InputParameter(
              controller: inputN,
              paramWidget: r'N',
              hintText: 'N = 1,2,3,...',
              wrongParam: wrongN,
            ),
            InputParameter(
              controller: inputn,
              paramWidget: r'n',
              hintText: 'n = 0,1,2,...,N',
              wrongParam: wrongn,
            ),
            calBox(
              () {
                setState(() {
                  onCal = true;
                  wrongk = false;
                  wrongx = false;
                  wrongN = false;
                  wrongn = false;
                });
                checkParam().then((value) {
                  onCal = false;
                  if (!wrongk && !wrongx && !wrongN && !wrongn) {
                    onCal = true;
                    getAnswer().then((value) {
                      setState(() {
                        onCal = false;
                        wrongk = false;
                        wrongx = false;
                        wrongN = false;
                        wrongn = false;
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
    var k = int.parse(inputk.text);
    var x = int.parse(inputx.text);
    var N = int.parse(inputN.text);
    var n = int.parse(inputn.text);
    fx = (nchoosex(k, x) * nchoosex(N - k, n - x)) / nchoosex(N, n);
    setState(() => onCalHint = true);
  }

  Future<void> checkParam() async {
    if (inputk.text == '') {
      setState(() => wrongk = true);
    } else {
      try {
        int k = int.parse(inputk.text);
        try {
          int x = int.parse(inputx.text);
          if (k <= x) {
            setState(() {
              wrongk = true;
              wrongx = true;
            });
          }
        } catch (e) {
          setState(() => wrongx = true);
        }
      } catch (e) {
        setState(() => wrongk = true);
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
    if (inputN.text == '') {
      setState(() => wrongN = true);
    } else {
      try {
        int N = int.parse(inputN.text);
        try {
          int n = int.parse(inputn.text);
          if (N <= n) {
            setState(() {
              wrongN = true;
              wrongn = true;
            });
          }
        } catch (e) {
          setState(() => wrongn = true);
        }
      } catch (e) {
        setState(() => wrongN = true);
      }
    }
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
  }
}
