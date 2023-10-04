import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:statweb/constants.dart';
import 'package:statweb/states/home/formular/formular_dialog.dart';
import 'package:statweb/states/quiz/quizPage_class.dart';

class QuizPage extends StatefulWidget {
  final int unit;
  // final String description;
  final Function() onBack;

  const QuizPage({
    Key? key,
    required this.unit,
    // required this.description,
    required this.onBack,
  }) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int scoreCheck = 0;
  bool onloadQuestion = false;
  bool onCheck = false;
  int questionID = 1;
  List<QuizQuestion> questions = [];

  String description = '';

  Future<void> getQuizData() async {
    setState(() {
      onloadQuestion = true;
    });
    await Firebase.initializeApp().then((v) async {
      await FirebaseFirestore.instance
          .collection('quiz')
          .where('unit', isEqualTo: widget.unit)
          .orderBy('id')
          .get()
          .then((value) {
        for (var data in value.docs) {
          QuizQuestion model = QuizQuestion(
            unit: data['unit'],
            id: data['id'],
            question: data['question'],
            choice: data['choice'],
            answer: data['answer'],
            choose: 5,
            solution: data['solution'],
            table: data['table'],
          );
          questions.add(model);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    switch (widget.unit) {
      case 1:
        setState(() => description = 'Probability');
        break;
      case 2:
        setState(() => description = 'Random Variable');
        break;
      case 3:
        setState(() => description = 'Discrete Probability Distributions');
        break;
      case 4:
        setState(() => description = 'Continuous Probability Distributions');
        break;
      case 5:
        setState(() => description = 'Sampling Distribution');
        break;
      case 6:
        setState(() => description = 'Estimation');
        break;
      case 7:
        setState(() => description = 'Hypothesis Testing');
        break;
      case 8:
        setState(() => description = 'Chi-Square Test');
        break;
      case 9:
        setState(
            () => description = 'Regression Analysis and Correlation Analysis');
        break;
      case 10:
        setState(() => description = 'Analysis of Variance (ANOVA)');
        break;
    }
    getQuizData().then((value) {
      setState(() {
        onloadQuestion = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // double widthUI = MediaQuery.of(context).size.width;
    return onloadQuestion
        ? myCircularLoading()
        : SingleChildScrollView(
            child: Column(
              children: [
                exams(questions[questionID - 1]),
                numberList(questions),
              ],
            ),
          );
  }

  Widget exams(QuizQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        quizHeader(),
        const SizedBox(height: 5),
        problemBox(question.id),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: 4,
          itemBuilder: (context, index) => choiceBox(index, question),
        ),
      ],
    );
  }

  Widget quizHeader() {
    double widthUI = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: widget.onBack,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: metallicBlue,
          ),
        ),
        Expanded(
          child: Text('  $description',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: enFont('bold', widthUI < 550 ? 25 : 30, glaucous)),
        ),
      ],
    );
  }

  Widget problemBox(int number) {
    double widthUI = MediaQuery.of(context).size.width;
    return Container(
      // height: widthUI < 501 ? null : 250,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 2, color: metallicBlue),
      ),
      child: Stack(
        children: [
          Center(
            child: onloadQuestion
                ? myCircularLoading()
                : Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                      left: 16,
                      bottom: 30,
                      top: 50,
                    ),
                    child: Column(
                      children: [
                        Text(
                          questions[questionID - 1].question,
                          style: thFont(
                              'bold', widthUI < 550 ? 16 : 18, Colors.black),
                        ),
                        questions[questionID - 1].table == ''
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: CachedNetworkImage(
                                  imageUrl: questions[questionID - 1].table,
                                  placeholder: (context, url) => Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))),
                                    child: myCircularLoading(),
                                  ),
                                  imageBuilder: (context, imageProvider) {
                                    return widthUI < mobileWidth
                                        ? InteractiveViewer(
                                            maxScale: 3.0,
                                            minScale: 0.8,
                                            child: Image(
                                              image: imageProvider,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          )
                                        : SizedBox(
                                            width: 500,
                                            child: Image(
                                              image: imageProvider,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          );
                                  },
                                  errorWidget: (context, url, error) => Center(
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15))),
                                      color: Colors.grey.shade500,
                                      child: Center(
                                        child: Text(
                                          'Error loading',
                                          style: enFont(
                                              'bold', 15, Colors.grey.shade400),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Container(
              alignment: Alignment.center,
              height: widthUI < 550 ? 30 : 40,
              width: widthUI < 550 ? 30 : 40,
              decoration: BoxDecoration(
                color: metallicBlue,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                number.toString(),
                style: enFont('bold', widthUI < 550 ? 16 : 20, Colors.white),
              ),
            ),
          ),
          onCheck
              ? Positioned(
                  bottom: 10,
                  right: 10,
                  child: solutionButton(questions[questionID - 1].solution),
                )
              : Container()
        ],
      ),
    );
  }

  // Widget choiceBox(String choice, String text) {
  Widget choiceBox(int index, QuizQuestion question) {
    double widthUI = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            questions[questionID - 1].choose = index;
          });
        },
        child: Container(
            alignment: Alignment.centerLeft,
            height: 50,
            decoration: BoxDecoration(
                color: onCheck
                    ? question.answer == index
                        ? Colors.green.shade100
                        : question.choose == index
                            ? Colors.red.shade100
                            : null
                    : question.choose == index
                        ? water
                        : null,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  width: 2,
                  color: onCheck
                      ? question.answer == index
                          ? Colors.green
                          : question.choose == index
                              ? Colors.red
                              : Colors.grey.shade400
                      : question.choose == index
                          ? metallicBlue
                          : Colors.grey.shade400,
                )),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    index == 0
                        ? 'A.  '
                        : index == 1
                            ? 'B.  '
                            : index == 2
                                ? 'C.  '
                                : 'D.  ',
                    style:
                        thFont('bold', widthUI < 550 ? 16 : 20, metallicBlue),
                  ),
                  Text(
                    onloadQuestion ? 'loading choice' : question.choice[index],
                    style:
                        thFont('bold', widthUI < 550 ? 16 : 20, Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget numberList(List<QuizQuestion> questions) {
    double widthUI = MediaQuery.of(context).size.width;
    return SizedBox(
      child: widthUI < 600
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [choiceList(), checkandfx()],
            )
          : Row(
              children: [
                choiceList(),
                const SizedBox(
                  width: 30,
                ),
                checkandfx()
              ],
            ),
    );
  }

  Widget choiceList() {
    double widthUI = MediaQuery.of(context).size.width;
    return SizedBox(
      height: widthUI < 501 ? 55 : 60,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 4.0),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  questionID = index + 1;
                });
              },
              backgroundColor: questionID == index + 1
                  ? metallicBlue
                  : onCheck
                      ? questions[index].answer == questions[index].choose
                          ? Colors.green.shade300
                          : Colors.red.shade300
                      : questions[index].choose == 5
                          ? paleYellow
                          : glaucous,
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: enFont(
                    'bold',
                    23,
                    questionID == index + 1
                        ? Colors.white
                        : questions[index].choose == 5
                            ? glaucous
                            : Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget checkandfx() {
    double widthUI = MediaQuery.of(context).size.width;
    return SizedBox(
      height: widthUI < 501 ? 55 : 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: FloatingActionButton(
              onPressed: () {
                scoreCheck = 0;

                for (var i in questions) {
                  if (i.answer == i.choose) {
                    scoreCheck = scoreCheck + 1;
                  }
                }

                bool chooseAll = true;
                for (var i in questions) {
                  if (i.choose == 5) chooseAll = false;
                }
                if (chooseAll) {
                  checkAnswer().then((value) => setState(() => questionID = 1));
                } else {}
              },
              backgroundColor: metallicBlue,
              child: const Center(
                  child: Icon(
                Icons.done_rounded,
                color: Colors.white,
                size: 30,
                // weight: 100,
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 4.0),
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const FormularDialog(),
                );
              },
              backgroundColor: metallicBlue,
              child: Center(
                // child: Icon(
                //   Icons.functions_rounded,
                //   color: Colors.white,
                // ),
                child: Image.asset(
                  'assets/icons/function2.png',
                  height: 28,
                  width: 28,
                ),
              ),
            ),
          ),
          onCheck
              ? Padding(
                  padding: const EdgeInsets.only(top: 12, left: 15.0),
                  child: Text(
                    '${scoreCheck.toString()}/${questions.length}',
                    style: enFont('bold', 30, metallicBlue),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Future<void> checkAnswer() async {
    setState(() {
      onCheck = true;
    });
  }

  Widget solutionButton(List<dynamic> urlList) {
    double widthUI = MediaQuery.of(context).size.width;
    return SizedBox(
      height: widthUI < 550 ? 30 : 40,
      width: widthUI < 550 ? 30 : 40,
      child: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: SizedBox(
                      width: 900,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: widthUI < mobileWidth
                              ? InteractiveViewer(
                                  maxScale: 3.0,
                                  minScale: 0.8,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: urlList.length,
                                    itemBuilder: (context, index) {
                                      return Image.network(urlList[index],
                                          fit: BoxFit.cover);
                                    },
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: urlList.length,
                                  itemBuilder: (context, index) {
                                    return Image.network(urlList[index],
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: myCircularLoading(),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                SizedBox(
                                                  height: 100,
                                                  width: 100,
                                                  child: Center(
                                                    child: Text(
                                                      'error loading',
                                                      style: enFont('bold', 15,
                                                          Colors.grey.shade500),
                                                    ),
                                                  ),
                                                ),
                                        fit: BoxFit.cover);
                                  },
                                ),
                        ),
                      ),
                    ),
                    // child: Image.network(url, fit: BoxFit.cover),
                  ));
        },
        backgroundColor: Colors.grey.shade400,
        child: Center(
          child: Text(
            '!',
            style: enFont('bold', 25, Colors.black),
          ),
        ),
      ),
    );
  }
}
