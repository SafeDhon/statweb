import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:statweb/constants.dart';

class InputParameter extends StatelessWidget {
  final TextEditingController controller;
  final String paramWidget;
  final String hintText;
  final bool readOnly;
  final bool onCalHint;
  final bool wrongParam;
  const InputParameter({
    Key? key,
    required this.controller,
    required this.paramWidget,
    required this.hintText,
    this.readOnly = false,
    this.onCalHint = false,
    this.wrongParam = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthUI = MediaQuery.of(context).size.width;
    double fontSize1 = widthUI < 501 ? 22 : 25;
    double fontSize2 = widthUI < 501 ? 18 : 20;
    double boxHeight = widthUI < 501 ? 45 : 50;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: widthUI < 501 ? 20 : 32,
      ),
      child: SizedBox(
          height: boxHeight,
          child: Row(
            children: [
              Expanded(
                  child: Math.tex(paramWidget,
                      textStyle: enFont('bold', fontSize1, metallicBlue))),
              Expanded(
                  child: Text('=',
                      style: enFont('bold', fontSize1, metallicBlue))),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: wrongParam ? Colors.red.shade300 : metallicBlue,
                        width: 2,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 6.0, right: 12.0, left: 12.0),
                    child: TextField(
                      // keyboardType:
                      // TextInputType.numberWithOptions(decimal: true),

                      // keyboardType: TextInputType.number,

                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp('[0-9.,-]'))
                      ],

                      readOnly: readOnly,
                      textAlignVertical: TextAlignVertical.top,
                      // textAlign: TextAlign.center,
                      style: enFont('bold', fontSize2, metallicBlue),
                      onChanged: (value) {},
                      controller: controller,
                      // keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: readOnly
                            ? enFont('bold', fontSize2,
                                onCalHint ? metallicBlue : beauBlue)
                            : enFont('bold', 20,
                                wrongParam ? Colors.red.shade300 : beauBlue),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
