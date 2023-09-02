import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../../constants.dart';

Padding headFormular(String formuText, BuildContext context) {
  double widthUI = MediaQuery.of(context).size.width;
  double fontSize = widthUI < 501 ? 23 : 28;
  return Padding(
    padding: const EdgeInsets.only(bottom: 24.0),
    child: Container(
      // width: 100,
      height: widthUI < 501 ? 130 : 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: metallicBlue, width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Math.tex(
            formuText,
            textStyle: enFont('semibold', fontSize, metallicBlue),
          ),
        ),
      ),
    ),
  );
}

Padding calBox(Function()? onTap, bool onCal) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 150,
        decoration: BoxDecoration(
            color: metallicBlue, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: onCal
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3.0,
                ))
            : Text('Calculate', style: enFont('bold', 20, Colors.white)),
      ),
    ),
  );
}

double fac(int number) {
  double factorial = 1;
  for (int i = 1; i <= number; i++) {
    factorial = factorial * i;
  }
  return factorial;
}

double nchoosex(int n, int x) {
  double ans;
  ans = (fac(n) / (fac(n - x) * fac(x)));
  return ans;
}
