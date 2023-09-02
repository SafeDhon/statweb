import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:statweb/constants.dart';
import 'package:statweb/states/formular/formular_class.dart';

class FormularDialog extends StatefulWidget {
  const FormularDialog({super.key});

  @override
  State<FormularDialog> createState() => _FormularDialogState();
}

class _FormularDialogState extends State<FormularDialog> {
  bool onChoose = false;
  var cal;

  @override
  Widget build(BuildContext context) {
    double widthUI = MediaQuery.of(context).size.width;
    double fontSize = widthUI < 501 ? 18 : 20;
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: SingleChildScrollView(
        child: SizedBox(
          width: 500,
          height: 850,
          child: onChoose
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              onChoose = false;
                            });
                          },
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            size: 25,
                            color: metallicBlue,
                          )),
                    ),
                    cal
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 24.0),
                  child: ListView.builder(
                      itemCount: formulars.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                cal = formulars[index].contain;
                                onChoose = true;
                              });
                            },
                            child: Container(
                              // width: 100,
                              height: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: metallicBlue, width: 2)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Math.tex(
                                    // mathStyle: MathStyle.text,
                                    formulars[index].formular,

                                    textStyle: enFont(
                                        'semibold', fontSize, metallicBlue),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
        ),
      ),
    );
  }
}
