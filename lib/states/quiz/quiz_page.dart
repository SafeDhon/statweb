import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:statweb/constants.dart';
import 'package:statweb/states/home/formular/formular_dialog.dart';
import 'package:statweb/states/quiz/quizPage_class.dart';

class QuizPage extends StatefulWidget {
  final int unit;
  final String description;
  final Function() onBack;

  const QuizPage({
    Key? key,
    required this.unit,
    required this.description,
    required this.onBack,
  }) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool onloadQuestion = false;
  bool onCheck = false;
  int questionID = 1;
  List<QuizQuestion> questions = [];

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
        // print('>>>>>>>>>>>>>>>>>>>>> $value');
        for (var data in value.docs) {
          QuizQuestion model = QuizQuestion(
              unit: data['unit'],
              id: data['id'],
              question: data['question'],
              chioce: data['chioce'],
              answer: data['answer'],
              choose: 5);
          questions.add(model);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();

    getQuizData().then((value) {
      setState(() {
        onloadQuestion = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return onloadQuestion
        ? myCircularLoading()
        : Column(
            children: [
              exams(questions[questionID - 1]),
              numberList(questions),
            ],
          );
  }

  Widget exams(QuizQuestion question) {
    return Column(
      children: [
        quizHeader(),
        const SizedBox(height: 5),
        problemBox(question.id),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) => choiceBox(index, question),
        ),
      ],
    );
  }

  Widget quizHeader() {
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
        Text('  ${widget.description}', style: enFont('bold', 25, glaucous)),
      ],
    );
  }

  Widget problemBox(int number) {
    return Container(
      height: 250,
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
                : Text(questions[questionID - 1].question),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: metallicBlue,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                number.toString(),
                style: enFont('bold', 20, Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget choiceBox(String choice, String text) {
  Widget choiceBox(int index, QuizQuestion question) {
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
                children: [
                  Text(
                    index == 0
                        ? 'A.  '
                        : index == 1
                            ? 'B.  '
                            : index == 2
                                ? 'C.  '
                                : 'D.  ',
                    style: enFont('bold', 25, metallicBlue),
                  ),
                  Text(
                    onloadQuestion ? 'loading chioce' : question.chioce[index],
                    style: enFont('regular', 22, Colors.black),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget numberList(List<QuizQuestion> questions) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      questionID = index + 1;
                    });
                  },
                  backgroundColor:
                      questions[index].choose == 5 ? paleYellow : metallicBlue,
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: enFont(
                        'bold',
                        23,
                        questions[index].choose == 5 ? glaucous : Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: FloatingActionButton(
              onPressed: () {
                bool chooseAll = true;
                for (var i in questions) {
                  if (i.choose == 5) chooseAll = false;
                }
                if (chooseAll) {
                  checkAnswer().then((value) => setState(() => questionID = 1));
                } else {
                  print('please choose the answer');
                }
              },
              backgroundColor: metallicBlue,
              child: const Center(child: Icon(Icons.done_rounded)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 8.0),
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => FormularDialog(),
                );
              },
              backgroundColor: metallicBlue,
              child: const Center(
                child: Text('fx'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkAnswer() async {
    setState(() {
      onCheck = true;
    });
  }
}
