import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:statweb/states/score/score_model.dart';

import '../../constants.dart';

class ScoreDesktop extends StatefulWidget {
  const ScoreDesktop({super.key});

  @override
  State<ScoreDesktop> createState() => _ScoreDesktopState();
}

class _ScoreDesktopState extends State<ScoreDesktop> {
  List<ScoreModel> scores = [];
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    readDataID().then((value) {
      setState(() {
        isloading = false;
      });
    });
  }

  Future<void> readDataID() async {
    setState(() {
      isloading = true;
    });
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('score')
          .get()
          .then((event) async {
        for (var doc in event.docs) {
          // var name;
          await FirebaseFirestore.instance
              .collection('user')
              .doc(doc.id)
              .get()
              .then(
            (value) async {
              // name = value['name'];
              await FirebaseFirestore.instance
                  .collection('score')
                  .doc(doc.id)
                  .get()
                  .then((event) {
                ScoreModel model = ScoreModel(
                  id: int.parse(doc.id),
                  name: '${value['name']} ${value['surname']}',
                  quiz1: int.parse(event['quiz1']),
                  quiz2: int.parse(event['quiz2']),
                  midterm: int.parse(event['midterm']),
                  finalterm: int.parse(event['final']),
                  total: int.parse(event['total']),
                );
                scores.add(model);
              });
            },
          );

          // ScoreModel model = ScoreModel(name: name);
          // print(model.name);
          // print("${doc.id} => ${doc.data()}");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 500,
      width: 1200,
      decoration: BoxDecoration(
        // color: Colors.pink,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: metallicBlue,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: columnHeader(),
            ),
            isloading
                ? SizedBox(height: 150, child: myCircularLoading())
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: scores.length,
                    itemBuilder: (context, index) {
                      return scoreWidget(
                        (index + 1).toString(),
                        scores[index].name,
                        scores[index].quiz1.toString(),
                        scores[index].quiz2.toString(),
                        scores[index].midterm.toString(),
                        scores[index].finalterm.toString(),
                        scores[index].total.toString(),
                      );
                    }),
          ],
        ),
      ),
    );
  }

  Row columnHeader() {
    return Row(
      children: [
        Expanded(flex: 2, child: headerStyle('Name - Surname')),
        Expanded(child: headerStyle('Quiz 1')),
        Expanded(child: headerStyle('Midterm')),
        Expanded(child: headerStyle('Quiz 2')),
        Expanded(child: headerStyle('Final')),
        Expanded(child: headerStyle('Total')),
      ],
    );
  }

  SizedBox scoreWidget(String index, String name, String quiz1, String quiz2,
      String midterm, String finalterm, String total) {
    return SizedBox(
      height: 40,
      child: Column(
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      '$index. $name',
                      style: TextStyle(
                          fontSize: 18,
                          color: metallicBlue,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600),
                    )),
                Expanded(child: studentStyle(quiz1)),
                Expanded(child: studentStyle(midterm)),
                Expanded(child: studentStyle(quiz2)),
                Expanded(child: studentStyle(finalterm)),
                Expanded(child: studentStyle(total)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text headerStyle(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 25,
          color: metallicBlue,
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w700),
    );
  }

  Text studentStyle(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 18,
          color: metallicBlue,
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w600),
    );
  }
}