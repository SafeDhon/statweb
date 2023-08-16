import 'package:flutter/material.dart';
import 'package:statweb/states/formular/head_formular.dart';
import 'package:statweb/states/formular/input_parameter.dart';

class Formular1 extends StatefulWidget {
  final String formu;

  const Formular1({
    Key? key,
    required this.formu,
  }) : super(key: key);

  @override
  State<Formular1> createState() => _Formular1State();
}

class _Formular1State extends State<Formular1> {
  bool onCal = false;
  bool onCalHint = false;

  // input parameter
  final inputn = TextEditingController();
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
              controller: inputn,
              paramWidget: r'n',
              hintText: 'n = 1,2,3,...',
              wrongParam: wrongn,
            ),
            calBox(
              () {
                setState(() {
                  onCal = true;
                  wrongn = false;
                });
                checkParam().then((value) {
                  onCal = false;
                  if (!wrongn) {
                    onCal = true;
                    getAnswer().then((value) {
                      setState(() {
                        onCal = false;
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
    var n = int.parse(inputn.text);
    fx = 1 / n;
    setState(() => onCalHint = true);
  }

  Future<void> checkParam() async {
    if (inputn.text == '') {
      setState(() => wrongn = true);
    } else {
      try {
        int.parse(inputn.text);
      } catch (e) {
        setState(() => wrongn = true);
      }
    }
  }
}
