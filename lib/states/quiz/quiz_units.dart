import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  // List<EBookPage> pages = [];
  // String unit = '';
  // String description = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 630,
      child: onChoose ? const QuizPage() : unitGrid(),
    );
  }

  Widget unitGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: quiz_units.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              // pages = ebook_units[index].pages;
              // unit = ebook_units[index].id.toString();
              // description = ebook_units[index].description;
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
                    child: Text(
                      quiz_units[index].description,
                      style: enFont('bold', 20, glaucous),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://drive.google.com/uc?export=view&id=${quiz_units[index].picture}',
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
                      ),
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
