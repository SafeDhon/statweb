import 'package:flutter/material.dart';
import 'package:statweb/constants.dart';

class FullScoreDialog extends StatelessWidget {
  final String userID;
  final String header;
  final String quiz1;
  final String quiz2;
  final String midterm;
  final String finalterm;
  final String total;
  const FullScoreDialog({
    Key? key,
    required this.userID,
    required this.header,
    required this.quiz1,
    required this.quiz2,
    required this.midterm,
    required this.finalterm,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: 200,
            child: Column(
              children: [
                Text(
                  header,
                  style: enFont('bold', 20, metallicBlue),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                scoreWidget('Quiz 1', quiz1),
                scoreWidget('Midterm', midterm),
                scoreWidget('Quiz 2', quiz2),
                scoreWidget('Final', finalterm),
                scoreWidget('Total', total),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget scoreWidget(String text, String score) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: glaucous),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Text(text, style: enFont('bold', 15, metallicBlue))),
            Expanded(child: Text('=', style: enFont('bold', 15, beauBlue))),
            Expanded(
                child: Text(score, style: enFont('bold', 15, metallicBlue)))
          ],
        ),
      ),
    );
  }
}
