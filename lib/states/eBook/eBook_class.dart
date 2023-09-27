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
    picture: 'illustrations%2Febook1.png?alt=media&token=3e6d4429-e110-49f8-8c7c-43a07d12e620',
    contains: Container(),
    pages: ebookU1,
  ),
  EBook(
    id: 2,
    description: 'Random Variable',
    picture: 'illustrations%2Febook2.png?alt=media&token=f0ae0505-63f0-4bf4-a8d9-623c56c3149e',
    contains: Container(),
    pages: ebookU2,
  ),
  EBook(
    id: 3,
    description: 'Discrete Probability Distributions',
    picture: 'illustrations%2Febook3.png?alt=media&token=0f3fc220-6692-40d5-89fc-b0c47df0437d',
    contains: Container(),
    pages: ebookU3,
  ),
  EBook(
    id: 4,
    description: 'Continuous Probability Distributions',
    picture: 'illustrations%2Febook4.png?alt=media&token=ac76aa63-0e71-4511-8111-cd85605b36fb',
    contains: Container(),
    pages: ebookU4,
  ),
  EBook(
    id: 5,
    description: 'Sampling Distribution',
    picture: 'illustrations%2Febook5.png?alt=media&token=21a2f190-2ea2-4d81-846f-8f79c338027c',
    contains: Container(),
    pages: ebookU5,
  ),
  EBook(
    id: 6,
    description: 'Estimation',
    picture: 'illustrations%2Febook6.png?alt=media&token=3bda2754-c11d-4736-9a84-2ff4dae8cade',
    contains: Container(),
    pages: ebookU6,
  ),
  EBook(
    id: 7,
    description: 'Hypothesis Testing',
    picture: 'illustrations%2Febook7.png?alt=media&token=5b7d83de-d77b-430a-97d0-9f55b13947b1',
    contains: Container(),
    pages: ebookU7,
  ),
  EBook(
    id: 8,
    description: 'Chi-Square Test',
    picture: 'illustrations%2Febook8.png?alt=media&token=ad7a7f9d-7124-48e5-824b-43fc7672a04a',
    contains: Container(),
    pages: ebookU8,
  ),
  EBook(
    id: 9,
    description: 'Regression Analysis and Correlation Analysis',
    picture: 'illustrations%2Febook9.png?alt=media&token=0503d939-644e-4d56-b723-89c5267acb81',
    contains: Container(),
    pages: ebookU9,
  ),
  EBook(
    id: 10,
    description: 'Analysis of Variance (ANOVA)',
    picture: 'illustrations%2Febook10.png?alt=media&token=842a7e5f-a853-4a51-aebc-afefca79dc2a',
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
