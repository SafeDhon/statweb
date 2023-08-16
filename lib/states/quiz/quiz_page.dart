import 'package:flutter/material.dart';
import 'package:statweb/constants.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        problemBox(1),
        choiceBox('A', 'text'),
        choiceBox('B', 'text'),
        choiceBox('C', 'text'),
        choiceBox('D', 'text'),
        numberList(),
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
          Center(child: Text('data')),
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

  Widget choiceBox(String choice, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () {},
        child: Container(
            alignment: Alignment.centerLeft,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(width: 2, color: metallicBlue)),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                children: [
                  Text(
                    '$choice.  ',
                    style: enFont('bold', 25, metallicBlue),
                  ),
                  Text(
                    text,
                    style: enFont('semibold', 25, Colors.black),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget numberList() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 8.0),
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: metallicBlue,
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: enFont('bold', 20, Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
