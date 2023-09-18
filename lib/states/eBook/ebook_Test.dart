// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:statweb/constants.dart';
import 'package:statweb/states/quiz/quiz_page.dart';

import 'navbar_ebook.dart';

class EbookPageTest extends StatefulWidget {
  final int unit;
  final String description;
  final Function() onBack;
  const EbookPageTest({
    Key? key,
    required this.unit,
    required this.description,
    required this.onBack,
  }) : super(key: key);

  @override
  State<EbookPageTest> createState() => _EbookPageTestState();
}

class _EbookPageTestState extends State<EbookPageTest> {
  bool onQuiz = false;
  bool onLoad = false;
  List<EbookPageTestClass> ebooks = [];
  int page = 0;

  Future<void> getEbooks() async {
    setState(() => onLoad = true);
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('ebooks')
          .where('unit', isEqualTo: widget.unit)
          .orderBy('page')
          .get()
          .then((value) {
        for (var data in value.docs) {
          EbookPageTestClass ebook = EbookPageTestClass(
            unit: data['unit'],
            page: data['page'],
            music: data['music'],
            vdo: data['vdo'],
            quiz: data['quiz'],
            contain: data['contain'],
          );
          ebooks.add(ebook);
        }
      });
    });
  }

  @override
  void initState() {
    getEbooks().then((value) {
      setState(() => onLoad = false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return onLoad
        ? myCircularLoading()
        : onQuiz
            ? QuizPage(
                onBack: () => setState(() => onQuiz = false),
                unit: ebooks[page].quiz,
                // description: widget.description,
              )
            : SizedBox(
                child: Column(
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
                            style: enFont('bold', size.width < 550 ? 25 : 30,
                                metallicBlue)),
                        Text('  ${widget.description}',
                            style: enFont(
                                'bold', size.width < 550 ? 25 : 30, glaucous)),
                      ],
                    ),
                    // Text('${ebooks[page].contain}'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: CachedNetworkImage(
                        imageUrl: ebooks[page].contain,
                        placeholder: (context, url) => Container(
                          height: 500,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: myCircularLoading(),
                        ),
                        imageBuilder: (context, imageProvider) {
                          return Image(
                            image: imageProvider,
                            fit: BoxFit.fitWidth,
                          );
                        },
                        errorWidget: (context, url, error) => Center(
                          child: Container(
                            height: 500,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            color: Colors.grey.shade500,
                            child: Center(
                              child: Text(
                                'Error loading',
                                style: enFont('bold', 15, Colors.grey.shade400),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    NavBarEBOOK(
                      backwardPress: () {
                        if (page != 0) {
                          setState(() => page = page - 1);
                        }
                      },
                      forwardPress: () {
                        if (page != ebooks.length) {
                          setState(() => page = page + 1);
                        }
                      },
                      quizPress: () => setState(() => onQuiz = true),
                      vdo: ebooks[page].vdo,
                      music: ebooks[page].music,
                      quiz: Container(),
                      page: '${(page + 1).toString()}/${ebooks.length}',
                    ),
                  ],
                ),
              );
  }
}

class EbookPageTestClass {
  int unit;
  int page;
  String music;
  String vdo;
  int quiz;
  String contain;
  EbookPageTestClass({
    required this.unit,
    required this.page,
    required this.music,
    required this.vdo,
    required this.quiz,
    required this.contain,
  });
}
