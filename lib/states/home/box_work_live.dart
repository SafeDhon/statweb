import 'dart:js' as js;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_shadow/simple_shadow.dart';

import 'package:statweb/constants.dart';
import 'package:statweb/my_icons_icons.dart';
import 'package:statweb/states/home/home.dart';
import 'package:statweb/states/home/manage_homework.dart';
import 'package:statweb/states/home/upload_dialog.dart';
import 'package:statweb/util/login_dialog.dart';

class MyWorkLiveNav extends StatefulWidget {
  // final Future future;
  const MyWorkLiveNav({
    Key? key,
    // required this.future,
  }) : super(key: key);

  @override
  State<MyWorkLiveNav> createState() => _MyWorkLiveNavState();
}

class _MyWorkLiveNavState extends State<MyWorkLiveNav> {
  bool onAdd = false;
  bool onEdit = false;
  var hws = [];
  String homeworkID = '';
  DateTime assign = DateTime(2023, 8, 20, 00, 00);
  DateTime deadline = DateTime(2023, 8, 20, 00, 00);
  String? description = 'No Description';
  String userID = '';
  String userName = '';
  String userType = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> getformPrefer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userID = preferences.getString('id')!;
      userName = preferences.getString('name')!;
      userType = preferences.getString('type')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthUI = MediaQuery.of(context).size.width;
    double headFontSize = widthUI < 1150 ? 28 : 35;
    double descriptFontSize = widthUI < 1150 ? 22 : 28;
    double subFontSize = widthUI < 1150 ? 15 : 20;
    return InkWell(
      onTap: () async {
        await getformPrefer().then((value) {
          if (userID == '') {
            showDialog(
              context: context,
              builder: (BuildContext context) => const LoginDialog(),
            ).then((value) async {
              // await getformPrefer();
            });
            // widget.future;
          } else {
            if (userID == 'student' && homeworkID.isNotEmpty) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => UploadDialog(
                      userID: userID, homeworkID: hws[0].id, userName: userName)

                  // : manageDialog(),
                  );
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const ManageHomeWorkDialog()
                  // : manageDialog(),
                  );
            }
          }
        });
      },
      child: Container(
        decoration: homeBox(metallicBlue),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 4),
          child: onAdd
              ? const Center(
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 9,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('homework')
                              // .where('activate', isEqualTo: true)
                              .orderBy('deadline')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              final snap = snapshot.data!.docs;
                              // var hws = [];
                              for (var data in snap) {
                                if (data['activate']) {
                                  hws.add(data);
                                }
                              }
                              if (hws.isNotEmpty) {
                                // setState(() => homeworkID = hws[0].id);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    textHomeBox(
                                        'Home work Live !!', headFontSize),
                                    textHomeBox(hws[0]['description'],
                                        descriptFontSize),
                                    SizedBox(
                                      width: widthUI < 1150 ? 230 : null,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: textHomeBox(
                                                    'Assign', subFontSize),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: textHomeBox(
                                                    DateFormat(widthUI < 1150
                                                            ? ':  d/MM/yy'
                                                            : ':  d MMM yyyy')
                                                        .format(hws[0]['assign']
                                                            .toDate()),
                                                    subFontSize),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: textHomeBox(
                                                    DateFormat('kk:mm').format(
                                                        hws[0]['assign']
                                                            .toDate()),
                                                    subFontSize),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: textHomeBox(
                                                    'Deadline', subFontSize),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: textHomeBox(
                                                    DateFormat(widthUI < 1150
                                                            ? ':  d/MM/yy'
                                                            : ':  d MMM yyyy')
                                                        .format(hws[0]
                                                                ['deadline']
                                                            .toDate()),
                                                    subFontSize),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: textHomeBox(
                                                    DateFormat('kk:mm').format(
                                                        hws[0]['deadline']
                                                            .toDate()),
                                                    subFontSize),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return noHomework();
                              }
                            } else {
                              return noHomework();
                            }
                          }),
                    ),
                    Expanded(
                        flex: widthUI < tabletWidth ? 3 : 4,
                        child: SimpleShadow(
                          opacity: 0.9, // Default: 0.5
                          color: Colors.black, // Default: Black
                          offset: const Offset(0, 0), // Default: Offset(2, 2)
                          sigma: 2,
                          child: Image.asset(
                            'assets/images/hwlive.png',
                            height: 500,
                          ),
                        )),
                  ],
                ),
        ),
      ),
    );
  }

  Widget noHomework() {
    double widthUI = MediaQuery.of(context).size.width;
    double headFontSize = widthUI < 1150 ? 28 : 35;
    double descriptFontSize = widthUI < 1150 ? 22 : 28;
    double subFontSize = widthUI < 1150 ? 15 : 20;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        textHomeBox('Home work Live !!', headFontSize),
        textHomeBox("Don't have homework", descriptFontSize),
        SizedBox(
          width: widthUI < 1150 ? 230 : null,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: textHomeBox('Assign', subFontSize),
                  ),
                  Expanded(
                    flex: 4,
                    child: textHomeBox(':  -', subFontSize),
                  ),
                  Expanded(
                    flex: 2,
                    child: textHomeBox('', subFontSize),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: textHomeBox('Deadline', subFontSize),
                  ),
                  Expanded(
                    flex: 4,
                    child: textHomeBox(':  -', subFontSize),
                  ),
                  Expanded(
                    flex: 2,
                    child: textHomeBox('', subFontSize),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
