import 'package:flutter/material.dart';

import 'package:statweb/states/formular/cal_page/formu1.dart';
import 'package:statweb/states/formular/cal_page/formu2.dart';
import 'package:statweb/states/formular/cal_page/formu3.dart';
import 'package:statweb/states/formular/cal_page/formu4.dart';
import 'package:statweb/states/formular/cal_page/formu5.dart';
import 'package:statweb/states/formular/cal_page/formu6.dart';
import 'package:statweb/states/formular/cal_page/formu7.dart';
import 'package:statweb/states/formular/cal_page/formu8.dart';
import 'package:statweb/states/formular/cal_page/formu9.dart';
import 'package:statweb/states/formular/cal_page/formu10.dart';
import 'package:statweb/states/formular/cal_page/formu11.dart';
import 'package:statweb/states/formular/cal_page/formu12.dart';
import 'package:statweb/states/formular/cal_page/formu13.dart';

class Formular {
  Widget contain;
  String formular;
  Formular({
    required this.contain,
    required this.formular,
  });
}

// String formu1 = r'f(x;n) = \frac 1 n  ;  x = x_1,x_2,x_3,...,x_n';
// String formu2 = r'f(x) = p^x q^{1-x}  ;  x = 0,1';
// String formu3 =
//     r'f(x) = P(X=x) = b(x;n,p) = {n \choose x}p^x(1-p)^{n-x}  ;  x = 0,1,2,...,n';
// String formu4 =
//     r'f(x_1,x_2,x_3,...,x_k) = \frac {n!} {x_1!x_2!x_3!...x_k!} p_1^{x_1}p_2^{x_2}p_3^{x_3}...p_k^{x_k} ; \sum_{i=1}^kx_i = n , \sum_{i=1}^kp_i = 1';
// String formu5 =
//     r'f(x) = P(X=x) = \frac{{k \choose x}{N-k \choose n-x}} {{N \choose n}}; x=0,1,2,3,...,k';
// String formu6 =
//     r'f(x) = P(X=x) = p(x;\mu) = \frac{e^{-\mu}\mu^x}{x!} ; x=0,1,2,3,...';
// String formu7 = r'Z = \frac{\bar{X}-\mu}{\sigma/\sqrt{n}}';
// String formu8 = r'Z = \frac{\bar{X}-\mu}{S/\sqrt{n}}';
// String formu9 = r't = \frac{\bar{X}-\mu}{S/\sqrt{n}}';
// String formu10 =
//     r'Z = \frac{(\bar{X_1}-\bar{X_2})-d_0}{\sqrt{\frac{\sigma_1^2}{n_1}+\frac{\sigma_2^2}{n_2}}}';
// String formu11 =
//     r'Z = \frac{(\bar{X_1}-\bar{X_2})-d_0}{\sqrt{\frac{S_1^2}{n_1}+\frac{S_2^2}{n_2}}}';
// String formu12 =
//     r't = \frac{(\bar{X_1}-\bar{X_2})-d_0}{S_p\sqrt{\frac{1}{n_1}+\frac{1}{n_2}}} ; S_p = \sqrt{\frac{(n_1-1)S_1^2+(n_2-1)S_2^2}{n_1+n_2-2}}';
// String formu13 =
//     r't = \frac{(\bar{X_1}-\bar{X_2})-d_0}{\sqrt{\frac{S_1^2}{n_1}+\frac{S_2^2}{n_2}}}';

String formu1 = r'f(x) = \frac 1 n  ;  x = x_1,x_2,x_3,...,x_n';
String formu2 = r'f(x) = p^x q^{1-x}';
String formu3 = r'f(x) = {n \choose x}p^x(1-p)^{n-x}';
String formu4 =
    r'f(x) = \frac {n!} {x_1!x_2!x_3!...x_k!} p_1^{x_1}p_2^{x_2}p_3^{x_3}...p_k^{x_k}';
String formu5 = r'f(x) = \frac{{k \choose x}{N-k \choose n-x}} {{N \choose n}}';
String formu6 =
    r'f(x) = \frac{e^{-\mu}\mu^x}{x!}';
String formu7 = r'Z = \frac{\bar{X}-\mu}{\sigma/\sqrt{n}}';
String formu8 = r'Z = \frac{\bar{X}-\mu}{S/\sqrt{n}}';
String formu9 = r't = \frac{\bar{X}-\mu}{S/\sqrt{n}}';
String formu10 =
    r'Z = \frac{(\bar{X_1}-\bar{X_2})-d_0}{\sqrt{\frac{\sigma_1^2}{n_1}+\frac{\sigma_2^2}{n_2}}}';
String formu11 =
    r'Z = \frac{(\bar{X_1}-\bar{X_2})-d_0}{\sqrt{\frac{S_1^2}{n_1}+\frac{S_2^2}{n_2}}}';
String formu12 =
    r't = \frac{(\bar{X_1}-\bar{X_2})-d_0}{S_p\sqrt{\frac{1}{n_1}+\frac{1}{n_2}}}';
String formu13 =
    r't = \frac{(\bar{X_1}-\bar{X_2})-d_0}{\sqrt{\frac{S_1^2}{n_1}+\frac{S_2^2}{n_2}}}';

List<Formular> formulars = [
  // 1
  Formular(contain: Formular1(formu: formu1), formular: formu1),

  // 2
  Formular(contain: Formular2(formu: formu2), formular: formu2),

  // 3
  Formular(contain: Formular3(formu: formu3), formular: formu3),

  // 4
  Formular(contain: Formular4(formu: formu4), formular: formu4),

  // 5
  Formular(contain: Formular5(formu: formu5), formular: formu5),

  // 6
  Formular(contain: Formular6(formu: formu6), formular: formu6),

  // 7
  Formular(contain: Formular7(formu: formu7), formular: formu7),

  // 8
  Formular(contain: Formular8(formu: formu8), formular: formu8),

  // 9
  Formular(contain: Formular9(formu: formu9), formular: formu9),

  // 10
  Formular(contain: Formular10(formu: formu10), formular: formu10),

  // 11
  Formular(contain: Formular11(formu: formu11), formular: formu11),

  // 12
  Formular(contain: Formular12(formu: formu12), formular: formu12),

  // 13
  Formular(contain: Formular13(formu: formu13), formular: formu13),
];
