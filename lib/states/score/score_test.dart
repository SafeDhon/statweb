import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statweb/constants.dart';
import 'package:statweb/states/score/fullScore_dialog.dart';
import 'package:statweb/states/score/score_model.dart';
import 'package:statweb/states/score/updateScore_dialog.dart';

class ScoreTest extends StatefulWidget {
  const ScoreTest({super.key});

  @override
  State<ScoreTest> createState() => _ScoreTestState();
}

class _ScoreTestState extends State<ScoreTest> {
  List<ScoreModel> scores = [];
  String userID = '';
  String userName = '';
  String userType = '';
  bool isloading = false;
  int midPix = 1030;
  int minPix = 750;

  @override
  void initState() {
    super.initState();

    getformPrefer().then((value) => isloading = false);
  }

  Future<void> getformPrefer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      isloading = true;
      userID = preferences.getString('id')!;
      userName = preferences.getString('name')!;
      userType = preferences.getString('type')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                ? SizedBox(height: 350, child: myCircularLoading())
                : scoreBuild()
          ],
        ),
      ),
    );
  }

  Row columnHeader() {
    double widthUI = MediaQuery.of(context).size.width;
    return widthUI < minPix
        ? Row(
            children: [
              Expanded(flex: 2, child: headerStyle('Name - Surname')),
              Expanded(child: headerStyle('Total')),
            ],
          )
        : widthUI < midPix
            ? Row(
                children: [
                  Expanded(flex: 2, child: headerStyle('Name - Surname')),
                  Expanded(child: headerStyle('Midterm')),
                  Expanded(child: headerStyle('Final')),
                  Expanded(child: headerStyle('Accumulated')),
                  Expanded(child: headerStyle('Total')),
                ],
              )
            : Row(
                children: [
                  Expanded(flex: 2, child: headerStyle('Name - Surname')),
                  Expanded(child: headerStyle('Quiz 1')),
                  Expanded(child: headerStyle('Midterm')),
                  Expanded(child: headerStyle('Quiz 2')),
                  Expanded(child: headerStyle('Final')),
                  Expanded(child: headerStyle('Report')),
                  Expanded(child: headerStyle('Homework')),
                  Expanded(child: headerStyle('Total')),
                ],
              );
  }

  Text headerStyle(String text) {
    double widthUI = MediaQuery.of(context).size.width;
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: widthUI < midPix ? 18 : 20,
          color: metallicBlue,
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w700),
    );
  }

  SizedBox scoreWidget(
      String index,
      String userID,
      String name,
      String surname,
      String quiz1,
      String quiz2,
      String midterm,
      String finalterm,
      String report,
      String homework,
      String total) {
    double widthUI = MediaQuery.of(context).size.width;
    double accumulated = double.parse(quiz1) +
        double.parse(quiz2) +
        double.parse(report) +
        double.parse(homework);
    return SizedBox(
      height: 40,
      child: Column(
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: userType == 'student' || userType == ''
                  ? widthUI < midPix
                      ? () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => FullScoreDialog(
                              userID: userID,
                              header: "$name $surname",
                              quiz1: quiz1,
                              quiz2: quiz2,
                              midterm: midterm,
                              finalterm: finalterm,
                              report: report,
                              homework: homework,
                              total: total,
                            ),
                          );
                        }
                      : () {}
                  : () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => UpdateScoreDialog(
                          userID: userID,
                          header: "$name $surname",
                          quiz1: quiz1,
                          quiz2: quiz2,
                          midterm: midterm,
                          finalterm: finalterm,
                          report: report,
                          homework: homework,
                          total: total,
                        ),
                      ).then((value) {});
                    },
              child: widthUI < minPix
                  ? Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              '$index. $name ${surname[0]}.',
                              style: enFont('semibold', 16, metallicBlue),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Expanded(child: studentStyle(total)),
                      ],
                    )
                  : widthUI < midPix
                      ? Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  '$index. $name ${surname[0]}.',
                                  style: enFont('semibold', 16, metallicBlue),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Expanded(child: studentStyle(midterm)),
                            Expanded(child: studentStyle(finalterm)),
                            Expanded(
                                child: studentStyle(accumulated.toString())),
                            Expanded(child: studentStyle(total)),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  '$index. $name ${surname[0]}.',
                                  style: enFont('semibold', 16, metallicBlue),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Expanded(child: studentStyle(quiz1)),
                            Expanded(child: studentStyle(midterm)),
                            Expanded(child: studentStyle(quiz2)),
                            Expanded(child: studentStyle(finalterm)),
                            Expanded(child: studentStyle(report)),
                            Expanded(child: studentStyle(homework)),
                            Expanded(child: studentStyle(total)),
                          ],
                        ),

              // Row(
              //   children: [
              //     Expanded(
              //         flex: 2,
              //         child: Text(
              //           '$index. $name ${surname[0]}.',
              //           style: enFont('semibold', 16, metallicBlue),
              //           maxLines: 1,
              //           overflow: TextOverflow.ellipsis,
              //         )),
              //     widthUI < midPix
              //         ? Container()
              //         : Expanded(child: studentStyle(quiz1)),
              //     Expanded(child: studentStyle(midterm)),
              //     widthUI < midPix
              //         ? Container()
              //         : Expanded(child: studentStyle(quiz2)),
              //     Expanded(child: studentStyle(finalterm)),
              //     widthUI < midPix
              //         ? Container()
              //         : Expanded(child: studentStyle(report)),
              //     widthUI < midPix
              //         ? Container()
              //         : Expanded(child: studentStyle(homework)),
              //     widthUI < midPix
              //         ? Expanded(child: studentStyle(accumulated.toString()))
              //         : Container(),
              //     Expanded(child: studentStyle(total)),
              //   ],
              // ),
            ),
          ),
        ],
      ),
    );
  }

  Text studentStyle(String text) {
    double widthUI = MediaQuery.of(context).size.width;
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 14,
          color: metallicBlue,
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w600),
    );
  }

  Widget scoreBuild() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('score')
            .orderBy('id')
            .snapshots(),
        // .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return myCircularLoading();
          }
          if (snapshot.hasData || snapshot.data!.docs.isNotEmpty) {
            final snap = snapshot.data!.docs;
            return ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: snap.length,
                itemBuilder: (context, index) {
                  return scoreWidget(
                    (index + 1).toString(),
                    snap[index].id.toString(),
                    snap[index]['name'],
                    snap[index]['surname'],
                    snap[index]['quiz1'],
                    snap[index]['quiz2'],
                    snap[index]['midterm'],
                    snap[index]['final'],
                    snap[index]['report'],
                    snap[index]['homework'],
                    snap[index]['total'],
                  );
                });
          } else {
            return SizedBox(
              height: 100,
              child: Center(
                  child: Text('Empty',
                      style: enFont('semibold', 20, metallicBlue))),
            );
          }
        });
  }
}
