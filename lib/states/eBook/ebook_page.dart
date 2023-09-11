import 'package:flutter/material.dart';

import 'package:statweb/constants.dart';
import 'package:statweb/states/eBook/eBook_class.dart';
import 'package:statweb/states/eBook/navbar_ebook.dart';
import 'package:statweb/states/quiz/quiz_page.dart';

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
  bool onQuiz = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return onQuiz
        ? QuizPage(
            onBack: () => setState(() => onQuiz = false),
            unit: widget.pages[page - 1].quiz[0],
            description: widget.pages[page - 1].quiz[1],
          )
        : SizedBox(
            height: size.height * 0.85,
            child: Column(
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
                Expanded(
                  child: SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 12, bottom: 4.0),
                        child: SingleChildScrollView(
                            child: widget.pages[page - 1].contain),
                      )),
                ),
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
                  quizPress: () => setState(() => onQuiz = true),
                  vdo: widget.pages[page - 1].vdo_url,
                  music: widget.pages[page - 1].music_url,
                  quiz: Container(),
                  page:
                      '${widget.pages[page - 1].page.toString()}/${widget.pages.length}',
                )
              ],
            ),
          );
  }
}
