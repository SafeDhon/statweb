// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:statweb/states/eBook/eBook_units.dart/u_01.dart';
import 'package:statweb/states/eBook/eBook_units.dart/u_02.dart';
import 'package:statweb/states/eBook/eBook_units.dart/u_03.dart';
import 'package:statweb/states/eBook/eBook_units.dart/u_04.dart';
import 'package:statweb/states/eBook/eBook_units.dart/u_05.dart';
import 'package:statweb/states/eBook/eBook_units.dart/u_06.dart';
import 'package:statweb/states/eBook/eBook_units.dart/u_07.dart';
import 'package:statweb/states/eBook/eBook_units.dart/u_08.dart';
import 'package:statweb/states/eBook/eBook_units.dart/u_09.dart';
import 'package:statweb/states/eBook/eBook_units.dart/u_10.dart';

class EBook {
  int id;
  String description;
  String picture;
  Widget contains;
  List<EBookPage> pages;
  EBook({
    required this.id,
    required this.description,
    required this.picture,
    required this.contains,
    required this.pages,
  });
}

List<EBook> ebook_units = [
  EBook(
    id: 1,
    description: 'Probability',
    picture: 'ebook1.png',
    contains: Container(),
    pages: ebookU1,
  ),
  EBook(
    id: 2,
    description: 'Random Variable',
    picture: 'ebook2.png',
    contains: Container(),
    pages: ebookU2,
  ),
  EBook(
    id: 3,
    description: 'Discrete Probability Distributions',
    picture: 'ebook3.png',
    contains: Container(),
    pages: ebookU3,
  ),
  EBook(
    id: 4,
    description: 'Continuous Probability Distributions',
    picture: 'ebook4.png',
    contains: Container(),
    pages: ebookU4,
  ),
  EBook(
    id: 5,
    description: 'Sampling Distribution',
    picture: 'ebook5.png',
    contains: Container(),
    pages: ebookU5,
  ),
  EBook(
    id: 6,
    description: 'Estimation',
    picture: 'ebook6.png',
    contains: Container(),
    pages: ebookU6,
  ),
  EBook(
    id: 7,
    description: 'Hypothesis Testing',
    picture: 'ebook7.png',
    contains: Container(),
    pages: ebookU7,
  ),
  EBook(
    id: 8,
    description: 'Chi-Square Test',
    picture: 'ebook8.png',
    contains: Container(),
    pages: ebookU8,
  ),
  EBook(
    id: 9,
    description: 'Regression Analysis and Correlation Analysis',
    picture: 'ebook9.png',
    contains: Container(),
    pages: ebookU9,
  ),
  EBook(
    id: 10,
    description: 'Analysis of Variance (ANOVA)',
    picture: 'ebook10.png',
    contains: Container(),
    pages: ebookU10,
  ),
];

class EBookPage {
  int unit;
  int page;
  Widget contain;
  String vdo_url;
  String music_url;
  List<dynamic> quiz;
  EBookPage({
    required this.unit,
    required this.page,
    required this.contain,
    required this.vdo_url,
    required this.music_url,
    required this.quiz,
  });
}
