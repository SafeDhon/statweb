// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:statweb/constants.dart';

Widget ebookTextWithTab(String text) {
  return Text('       $text', style: thFont('regular', 18, Colors.black));
}

Widget ebookText(String text) {
  return Text(text, style: thFont('regular', 18, Colors.black));
}

Widget ebookTextHead1(String text) {
  return Text(text, style: thFont('bold', 23, Colors.black));
}

Widget ebookImage(String url) {
  return CachedNetworkImage(
    imageUrl: "https://drive.google.com/uc?export=view&id=$url",
    placeholder: (context, url) => myCircularLoading(),
    imageBuilder: (context, imageProvider) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      );
    },
  );
}
