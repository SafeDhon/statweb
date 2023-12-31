// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:statweb/constants.dart';

Widget ebookTextWithTab(String text) {
  return Text('       $text', style: thFont('regular', 18, Colors.black));
}

Widget ebookText(String text) {
  return Text(text, style: thFont('regular', 18, Colors.black));
}

Widget ebookTextBold(String text) {
  return Text(text, style: thFont('bold', 18, Colors.black));
}

Widget ebookTextHead1(String text) {
  return Text(text, style: thFont('bold', 23, Colors.black));
}

Widget ebookMath(String text) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Math.tex(
      text,
      textStyle: enFont('regular', 18, Colors.black),
      mathStyle: MathStyle.text,
    ),
  );
}

Widget spanText(List<InlineSpan> list) {
  return Text.rich(
      TextSpan(style: thFont('bold', 18, Colors.black), children: list));
}

TextSpan ebookTextSpan(String text, String weight) {
  return TextSpan(text: text, style: thFont(weight, 18, Colors.black));
}

Widget ebookImage(String path, double height) {
  return Center(
    child: SizedBox(
      height: height,
      child: CachedNetworkImage(
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/reportstatweb.appspot.com/o/$path',
        placeholder: (context, url) => myCircularLoading(),
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                // fit: BoxFit.fill,
              ),
            ),
          );
        },
        errorWidget: (context, url, error) => Center(
          child: Text(
            'Error loading',
            style: enFont('bold', 15, Colors.grey.shade400),
          ),
        ),
      ),
      // child: Image.asset('/images/ebooks/$path',
      //     fit: BoxFit.fill,
      //     errorBuilder: (context, url, error) => Center(
      //           child: Text(
      //             'Error loading',
      //             style: enFont('bold', 15, Colors.grey.shade400),
      //           ),
      //         ),
      //     frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
      //         // SimpleShadow(
      //         //     opacity: 0.9, // Default: 0.5
      //         //     color: Colors.black, // Default: Black
      //         //     offset: const Offset(0, 0), // Default: Offset(2, 2)
      //         //     sigma: 2,
      //         //     child: child),
      //         child),
    ),
  );
}
