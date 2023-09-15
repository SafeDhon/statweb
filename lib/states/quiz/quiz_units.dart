import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:statweb/states/quiz/quiz_class.dart';
import 'package:statweb/states/quiz/quiz_page.dart';

import '../../constants.dart';

class QuizUnit extends StatefulWidget {
  const QuizUnit({super.key});

  @override
  State<QuizUnit> createState() => _QuizUnitState();
}

class _QuizUnitState extends State<QuizUnit> {
  bool onChoose = false;
  int unitChoose = 0;
  String descriptionQuiz = '';
  // List<EBookPage> pages = [];
  // String unit = '';
  // String description = '';

  @override
  Widget build(BuildContext context) {
    // height: 630,
    return onChoose
        ? QuizPage(
            onBack: () => setState(() => onChoose = false),
            unit: unitChoose,
            description: descriptionQuiz,
          )
        : unitGrid();
  }

  Widget unitGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      primary: false,
      shrinkWrap: true,
      itemCount: quiz_units.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              // pages = ebook_units[index].pages;
              // unit = ebook_units[index].id.toString();
              // description = ebook_units[index].description;
              unitChoose = quiz_units[index].id;
              descriptionQuiz = quiz_units[index].description;
              onChoose = true;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                // color: metallicBlue,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 2, color: metallicBlue)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Text(
                      'Quiz ${quiz_units[index].id}',
                      style: enFont('bold', 25, metallicBlue),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                    
                      quiz_units[index].description,
                      textAlign: TextAlign.center,
                      style: enFont('bold', 20, glaucous),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://firebasestorage.googleapis.com/v0/b/reportstatweb.appspot.com/o/${quiz_units[index].picture}',
                        placeholder: (context, url) => myCircularLoading(),
                        imageBuilder: (context, imageProvider) {
                          return SimpleShadow(
                            opacity: 0.9, // Default: 0.5
                            color: Colors.black, // Default: Black
                            offset: const Offset(0, 0), // Default: Offset(2, 2)
                            sigma: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  // fit: BoxFit.fill,
                                ),
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
                      // child: Image.asset(
                      //   '/images/illustrations/${quiz_units[index].picture}',
                      //   fit: BoxFit.fill,
                      //   errorBuilder: (context, url, error) => Center(
                      //     child: Text(
                      //       'Error loading',
                      //       style: enFont('bold', 15, Colors.grey.shade400),
                      //     ),
                      //   ),
                      //   frameBuilder: (context, child, frame,
                      //           wasSynchronouslyLoaded) =>
                      //       SimpleShadow(
                      //           opacity: 0.9, // Default: 0.5
                      //           color: Colors.black, // Default: Black
                      //           offset:
                      //               const Offset(0, 0), // Default: Offset(2, 2)
                      //           sigma: 2,
                      //           child: child),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
