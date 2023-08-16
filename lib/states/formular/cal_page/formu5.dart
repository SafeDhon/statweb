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

  // input parameter
  final inputk = TextEditingController();
  final inputx = TextEditingController();
  final inputN = TextEditingController();
  final inputn = TextEditingController();
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
                hintText: 'k = 1,2,3,...'),
            InputParameter(
                controller: inputx,
                paramWidget: r'x',
                hintText: 'x = 0,1,2,...,k'),
            InputParameter(
              controller: inputN,
              paramWidget: r'N',
              hintText: 'N = 1,2,3,...',
            ),
            InputParameter(
              controller: inputn,
              paramWidget: r'n',
              hintText: 'n = 0,1,2,...',
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
    var k = int.parse(inputk.text);
    var x = int.parse(inputx.text);
    var N = int.parse(inputN.text);
    var n = int.parse(inputn.text);
    fx = (nchoosex(k, x) * nchoosex(N - k, n - x)) / nchoosex(N, n);
  }
}
