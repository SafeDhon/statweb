import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:statweb/constants.dart';
import 'package:statweb/states/score/score_model.dart';

class ScoreTest extends StatefulWidget {
  const ScoreTest({super.key});

  @override
  State<ScoreTest> createState() => _ScoreTestState();
}

class _ScoreTestState extends State<ScoreTest> {
  List<ScoreModel> scores = [];
  bool isloading = false;
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
                // ScoreModel model = ScoreModel(
                //   id: int.parse(doc.id),
                //   name: '${value['name']} ${value['surname'][0]}.',
                //   quiz1: int.parse(event['quiz1']),
                //   quiz2: int.parse(event['quiz2']),
                //   midterm: int.parse(event['midterm']),
                //   finalterm: int.parse(event['final']),
                //   total: int.parse(event['total']),
                // );
                // scores.add(model);
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        // .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData || snapshot.data!.docs.isNotEmpty) {
            final snap = snapshot.data!.docs;
            var scores = [];
            // for (var data in snap) {
            //   if (data.id == homeworkid) {
            //     works.add(data);
            //   }
            //   // works.add(data);
            // }
            if (scores == []) {
              return Text('Empty', style: enFont('semibold', 20, metallicBlue));
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snap.length,
                  itemBuilder: (context, index) {
                    return Text(snap[index].id);
                  });
            }
          } else {
            return SizedBox(
              height: 100,
              child: Center(
                  child: Text('Empty',
                      style: enFont('semibold', 20, metallicBlue))),
            );
          }
          // final snap = snapshot.data!.docs;
          // return ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: snap.length,
          //     itemBuilder: (context, index) {
          //       return snap[index].id == homeworkID3
          //           // ?Text(snap[index]['name'])
          //           ? homeworksendContainer(snap[index], deadline)
          //           : null;
          //     });
        });
  }
}
