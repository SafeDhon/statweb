// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

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
    picture: '12pNF1vGJKNoTJx7kCmKQLbqqbRYakt19',
    contains: Container(),
    pages: ebookU1,
  ),
  EBook(
    id: 2,
    description: 'Random Variable',
    picture: '1ctxicdgJA-z1El-Lxk8UltoLTpERz_7L',
    contains: Container(),
    pages: ebookU2,
  ),
  EBook(
    id: 3,
    description: 'Discrete Probability Distributions',
    picture: '14ljP2B6oOQn_vqIR0kYvBXAPHiFZ-OiS',
    contains: Container(),
    pages: ebookU3,
  ),
  EBook(
    id: 4,
    description: 'Continuous Probability Distributions',
    picture: '14Q6s_YCp705b8bbyhclNxKtr491Vko06',
    contains: Container(),
    pages: ebookU4,
  ),
  EBook(
    id: 5,
    description: 'Sampling Distribution',
    picture: '18AEodw3zTOeH1gCDkk5ez2DO1gPvsEYl',
    contains: Container(),
    pages: ebookU5,
  ),
  EBook(
    id: 6,
    description: 'Estimation',
    picture: '1Nko5ze6kwdnVxRsbjipT-zUS2z8zF_BO',
    contains: Container(),
    pages: ebookU6,
  ),
  EBook(
    id: 7,
    description: 'Hypothesis Testing',
    picture: '1xC8635m8O7ECLX6q0lvI15lYYaZCp5q8',
    contains: Container(),
    pages: ebookU7,
  ),
  EBook(
    id: 8,
    description: 'Chi-Square Test',
    picture: '1o_gO7UbujiaWS8-VGOGqjoT9kzlp4-st',
    contains: Container(),
    pages: ebookU8,
  ),
  EBook(
    id: 9,
    description: 'Regression Analysis and Correlation Analysis',
    picture: '12m6_PdcmwhfQWsxOj2y-m6I1DrvIM3y-',
    contains: Container(),
    pages: ebookU9,
  ),
  EBook(
    id: 10,
    description: 'Analysis of Variance (ANOVA)',
    picture: '1xXlXl4tcGCOTIX481-C7L1Y4dCujCdvw',
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
  Widget quiz;
  EBookPage({
    required this.unit,
    required this.page,
    required this.contain,
    required this.vdo_url,
    required this.music_url,
    required this.quiz,
  });
}

List<EBookPage> ebookU1 = [
  EBookPage(
      unit: 1,
      page: 1,
      contain: Container(
        child: Text('This is page 11111'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
  EBookPage(
      unit: 1,
      page: 2,
      contain: Container(
        child: Text('This is page 2 นาขาบ'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
];

List<EBookPage> ebookU2 = [
  EBookPage(
      unit: 1,
      page: 1,
      contain: Container(
        child: Text('This is page 11111'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
  EBookPage(
      unit: 1,
      page: 2,
      contain: Container(
        child: Text('This is page 2 นาขาบ'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
];

List<EBookPage> ebookU3 = [
  EBookPage(
      unit: 1,
      page: 1,
      contain: Container(
        child: Text('This is page 11111'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
  EBookPage(
      unit: 1,
      page: 2,
      contain: Container(
        child: Text('This is page 2 นาขาบ'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
];

List<EBookPage> ebookU4 = [
  EBookPage(
      unit: 1,
      page: 1,
      contain: Container(
        child: Text('This is page 11111'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
  EBookPage(
      unit: 1,
      page: 2,
      contain: Container(
        child: Text('This is page 2 นาขาบ'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
];

List<EBookPage> ebookU5 = [
  EBookPage(
      unit: 1,
      page: 1,
      contain: Container(
        child: Text('This is page 11111'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
  EBookPage(
      unit: 1,
      page: 2,
      contain: Container(
        child: Text('This is page 2 นาขาบ'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
];

List<EBookPage> ebookU6 = [
  EBookPage(
      unit: 1,
      page: 1,
      contain: Container(
        child: Text('This is page 11111'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
  EBookPage(
      unit: 1,
      page: 2,
      contain: Container(
        child: Text('This is page 2 นาขาบ'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
];

List<EBookPage> ebookU7 = [
  EBookPage(
      unit: 1,
      page: 1,
      contain: Container(
        child: Text('This is page 11111'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
  EBookPage(
      unit: 1,
      page: 2,
      contain: Container(
        child: Text('This is page 2 นาขาบ'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
];

List<EBookPage> ebookU8 = [
  EBookPage(
      unit: 1,
      page: 1,
      contain: Container(
        child: Text('This is page 11111'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
  EBookPage(
      unit: 1,
      page: 2,
      contain: Container(
        child: Text('This is page 2 นาขาบ'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
];

List<EBookPage> ebookU9 = [
  EBookPage(
      unit: 1,
      page: 1,
      contain: Container(
        child: Text('This is page 11111'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
  EBookPage(
      unit: 1,
      page: 2,
      contain: Container(
        child: Text('This is page 2 นาขาบ'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
];

List<EBookPage> ebookU10 = [
  EBookPage(
      unit: 1,
      page: 1,
      contain: Container(
        child: Text('This is page 11111'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
  EBookPage(
      unit: 1,
      page: 2,
      contain: Container(
        child: Text('This is page 2 นาขาบ'),
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
];
