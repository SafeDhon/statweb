import 'package:flutter/material.dart';
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
          builder: (BuildContext context) => FormularDialog(),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: beauBlue,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [homeBoxShadow()],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    Text(
                      'Calculator !!',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                        fontSize: headFontSize,
                        fontWeight: FontWeight.w700,
                        shadows: const [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black54,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Statistic Formular',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                        fontSize: descriptFontSize,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black54,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/calculator.png',
                  height: 500,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
