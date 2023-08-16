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
    description: 'Test Description',
    picture: '1vqrFYWOjfza5yvjHpBxAuBWVx2uhgqcH',
    contains: Container(),
    pages: ebookU1,
  ),
  EBook(
    id: 2,
    description: 'Test Description',
    picture: '1k35FXBIAhfC4qpaS8sQBgHfnLeyx0OIZ',
    contains: Container(),
    pages: ebookU2,
  ),
  EBook(
    id: 3,
    description: 'Test Description',
    picture: '1iz_t_-BPJD2vfiTXfpkXbbYBiPCxIyrS',
    contains: Container(),
    pages: ebookU3,
  ),
  EBook(
    id: 4,
    description: 'Test Description',
    picture: '1L3h2WJK-dXDFSta1u6lVM-gpI3qq5iQg',
    contains: Container(),
    pages: ebookU4,
  ),
  EBook(
    id: 5,
    description: 'Test Description',
    picture: '1vW1cDdQpJhrVba4uU131zGEykjNw2AJy',
    contains: Container(),
    pages: ebookU5,
  ),
  EBook(
    id: 6,
    description: 'Test Description',
    picture: '1liIuPmRViTIPCanWlhUsLwtaMwRZRl3g',
    contains: Container(),
    pages: ebookU6,
  ),
  EBook(
    id: 7,
    description: 'Test Description',
    picture: '1Bu6YC45ZvzV8UC3kXtECmzO0sJO5R-e-',
    contains: Container(),
    pages: ebookU7,
  ),
  EBook(
    id: 8,
    description: 'Test Description',
    picture: '17OOpg7VPI4o7eUAqe_322BBqFXEmMaYr',
    contains: Container(),
    pages: ebookU8,
  ),
  EBook(
    id: 9,
    description: 'Test Description',
    picture: '1MyEXMpnwWOJoXREYTFttrP9NIHGPeLZE',
    contains: Container(),
    pages: ebookU9,
  ),
  EBook(
    id: 10,
    description: 'Test Description',
    picture: '1LjcIGbTheOPB-xVrD8cEaimjdceH0go9',
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
