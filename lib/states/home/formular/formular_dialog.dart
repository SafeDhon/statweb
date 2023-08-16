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
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: SizedBox(
        width: 500,
        child: onChoose
            ? cal
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
                                border:
                                    Border.all(color: metallicBlue, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Math.tex(
                                  formulars[index].formular,
                                  textStyle:
                                      enFont('semibold', 20, metallicBlue),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}
