import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:statweb/constants.dart';

import 'package:statweb/states/formular/formular_class.dart';

class FormularList extends StatefulWidget {
  const FormularList({super.key});

  @override
  State<FormularList> createState() => _FormularListState();
}

class _FormularListState extends State<FormularList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: formulars.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: OverflowBox(
              child: Math.tex(
                formulars[index].formular,
                textStyle: enFont('regular', 10, metallicBlue),
                
              ),
            ),
          );
        });
  }
}
