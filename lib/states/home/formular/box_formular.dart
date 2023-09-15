import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:statweb/constants.dart';
import 'package:statweb/states/home/formular/formular_dialog.dart';

class MyFormularNav extends StatelessWidget {
  const MyFormularNav({super.key});

  @override
  Widget build(BuildContext context) {
    double widthUI = MediaQuery.of(context).size.width;
    double headFontSize = widthUI < 1150 ? 28 : 35;
    double descriptFontSize = widthUI < 1150 ? 22 : 22;
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => const FormularDialog(),
        );
      },
      child: Container(
        decoration: homeBox(glaucous),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textHomeBox('Calculator !!', headFontSize),
     
                    textHomeBox('Statistic Formular', descriptFontSize)
             
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SimpleShadow(
                  opacity: 0.9, // Default: 0.5
                  color: Colors.black, // Default: Black
                  offset: const Offset(0, 0), // Default: Offset(2, 2)
                  sigma: 2,
                  child: Image.asset(
                    'assets/images/calculator.png',
                    height: 500,
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
