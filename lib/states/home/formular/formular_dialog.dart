// ignore_for_file: prefer_typing_uninitialized_variables

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
  ScrollController formularScroll = ScrollController();
  bool onChoose = false;
  var cal;

  @override
  Widget build(BuildContext context) {
    double widthUI = MediaQuery.of(context).size.width;
    double fontSize = widthUI < 501 ? 18 : 20;
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: SizedBox(
        width: 500,
        height: 850,
        child: onChoose
            ? SingleChildScrollView(
                child: Column(
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
                    cal,
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  bottom: 16.0,
                  left: 24.0,
                  right: 8.0,
                ),
                child: RawScrollbar(
                  controller: formularScroll,
                  thumbColor: glaucous.withOpacity(0.6),
                  radius: const Radius.circular(20),
                  thumbVisibility: true,
                  thickness: 10,
                  scrollbarOrientation: ScrollbarOrientation.right,

                  // isAlwaysShown: true,
                  // trackVisibility: true,
                  // interactive: true,
                  // showTrackOnHover: true,
                  // hoverThickness: 100,

                  child: ListView.builder(
                      controller: formularScroll,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: formulars.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                            right: 16.0,
                          ),
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
