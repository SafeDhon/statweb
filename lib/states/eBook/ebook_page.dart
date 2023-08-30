import 'package:flutter/material.dart';

import 'package:statweb/constants.dart';
import 'package:statweb/states/eBook/eBook_class.dart';
import 'package:statweb/states/eBook/navbar_ebook.dart';

class EBookpage extends StatefulWidget {
  final List<EBookPage> pages;
  final String unit;
  final String description;
  final Function() onBack;
  const EBookpage({
    Key? key,
    required this.pages,
    required this.unit,
    required this.description,
    required this.onBack,
  }) : super(key: key);

  @override
  State<EBookpage> createState() => _EBookpageState();
}

class _EBookpageState extends State<EBookpage> {
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: widget.onBack,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: metallicBlue,
              ),
            ),
            const SizedBox(width: 5),
            Text('Unit ${widget.unit}',
                style: enFont('bold', 30, metallicBlue)),
            Text('  ${widget.description}',
                style: enFont('bold', 30, glaucous)),
          ],
        ),
        Expanded(child: Center(child: widget.pages[page - 1].contain)),
        NavBarEBOOK(
          backwardPress: () {
            if (page != 1) {
              setState(() {
                page = page - 1;
              });
            }
          },
          forwardPress: () {
            if (page != widget.pages.length) {
              setState(() {
                page = page + 1;
              });
            }
          },
          vdo: 'vdo',
          music: 'music',
          quiz: Container(),
          page:
              '${widget.pages[page - 1].page.toString()}/${widget.pages.length}',
        )
      ],
    );
  }
}
