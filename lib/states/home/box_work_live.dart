import 'dart:js' as js;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_shadow/simple_shadow.dart';

import 'package:statweb/constants.dart';
import 'package:statweb/states/home/home.dart';
import 'package:statweb/states/home/upload_dialog.dart';
import 'package:statweb/util/login_dialog.dart';

class MyWorkLiveNav extends StatefulWidget {
  const MyWorkLiveNav({
    Key? key,
  }) : super(key: key);

  @override
  State<MyWorkLiveNav> createState() => _MyWorkLiveNavState();
}

class _MyWorkLiveNavState extends State<MyWorkLiveNav> {
  bool onAdd = false;
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
    getFireBaseDateTime().then((value) {
      setState(() {
        onAdd = false;
      });
    });
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
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) => userType == 'student'
                  ? UploadDialog(
                      userID: userID,
                      homeworkID: homeworkID,
                      userName: userName)
                  : manageDialog(),
            );
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textHomeBox('Home work Live !!', headFontSize),
                          textHomeBox(description.toString(), descriptFontSize),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: textHomeBox('Assign', subFontSize),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: textHomeBox(
                                        DateFormat(widthUI < 1150
                                                ? ':  d/MM/yy'
                                                : ':  d MMM yyyy')
                                            .format(assign),
                                        subFontSize),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: textHomeBox(
                                        DateFormat('kk:mm').format(assign),
                                        subFontSize),
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
                                    child: textHomeBox(
                                        DateFormat(widthUI < 1150
                                                ? ':  d/MM/yy'
                                                : ':  d MMM yyyy')
                                            .format(deadline),
                                        subFontSize),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: textHomeBox(
                                        DateFormat('kk:mm').format(deadline),
                                        subFontSize),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
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

  Future getFireBaseDateTime() async {
    setState(() => onAdd = true);
    var getHomework = await FirebaseFirestore.instance
        .collection('homework')
        .orderBy('deadline')
        .get();
    var homework = getHomework.docs.first;
    DateTime deadline = homework['deadline'].toDate();
    DateTime assign = homework['assign'].toDate();
    setState(() {
      homeworkID = homework.id;
      description = homework['description'];
      this.deadline = DateTime(
        deadline.year,
        deadline.month,
        deadline.day,
        deadline.hour,
        deadline.minute,
      );
      this.assign = DateTime(
        assign.year,
        assign.month,
        assign.day,
        assign.hour,
        assign.minute,
      );
    });
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    await pickDescription(dateTime);
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: deadline,
        firstDate: DateTime(2020), // start year
        lastDate: DateTime(2050), // last year
        builder: (context, child) {
          return dateTimePickTheme(context, child);
        },
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: deadline.hour,
          minute: deadline.minute,
        ),
        builder: (context, child) {
          return dateTimePickTheme(context, child);
        },
      );

  Future<void> pickDescription(DateTime dateTime) async {
    // TextEditingController controller = TextEditingController();
    String description = 'No Description';
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Add work description',
          style: enFont('omeibold', 18, metallicBlue),
        ),
        content: SizedBox(
          width: 200,
          child: TextField(
            onChanged: (value) {
              description = value.trim();
            },
            // controller: controller,
            decoration: InputDecoration(
              hintText: "Description",
              hintStyle: enFont('omeibold', 15, beauBlue),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: metallicBlue)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: metallicBlue)),
            ),

            style: enFont('omeibold', 15, metallicBlue),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCLE',
              style: enFont('omeibold', 15, metallicBlue),
            ),
          ),
          TextButton(
            onPressed: () {
              addFirebase(description, dateTime).then(
                (value) {
                  setState(() {
                    onAdd = false;
                    deadline = dateTime;
                    assign = DateTime.now();
                    this.description = description;
                  });
                  Navigator.pop(context);
                },
              );
            },
            child: Text(
              'OK',
              style: enFont('omeibold', 15, metallicBlue),
            ),
          ),
        ],
      ),
    );
    // return controller.toString();
  }

  Future addFirebase(String addDescript, DateTime addDateTime) async {
    setState(() => onAdd = true);
    final data = <String, dynamic>{
      'deadline': addDateTime,
      'description': addDescript,
      'assign': DateTime.now(),
    };

    FirebaseFirestore.instance
        .collection("homework")
        .add(data)
        .then((value) => print('$deadline $description'));
  }

  Widget manageDialog() {
    // getHomeworkList();
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: SizedBox(
        width: 250,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('homework')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final snap = snapshot.data!.docs;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snap.length,
                            itemBuilder: (context, index) {
                              return homeworkContainer(
                                  snap[index], snap[index].id);
                            });
                      } else {
                        return const SizedBox();
                      }
                    }),
                addHomeworkButt(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addHomeworkButt() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: InkWell(
        onTap: pickDateTime,
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: metallicBlue,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  'Add new homework',
                  style: enFont('bold', 18, Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget homeworkContainer(
      QueryDocumentSnapshot<Object?> object, String homeworkID) {
    DateTime assign = object['assign'].toDate();
    DateTime deadline = object['deadline'].toDate();
    String assignShow = DateFormat('d MMM kk:mm').format(assign);
    String deadlineShow = DateFormat('d MMM kk:mm').format(deadline);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          print(object.id);
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  homeworkSendDialog(object.id, object['deadline']));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: metallicBlue),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${object['description']}',
                      style: enFont('semibold', 20, metallicBlue),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      '$assignShow - $deadlineShow',
                      style: enFont('semibold', 14, glaucous),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
                IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('homework')
                        .doc(homeworkID)
                        .delete();
                  },
                  icon: const Icon(Icons.cancel_rounded),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget homeworkSendDialog(String homeworkid, var deadline) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: SizedBox(
        width: 250,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text('Sended List',style: enFont('bold', 20, metallicBlue)),
                //     IconButton(onPressed: () {}, icon:  const Icon(Icons.cancel_outlined),),
                //   ],
                // ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collectionGroup('homeworks')
                        // .orderBy('timestamp')
                        // .where('homework_id', isEqualTo: 'bROd3BBIs8S5bUOCS5Nk')
                        .snapshots(),
                    // .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData || snapshot.data!.docs.isNotEmpty) {
                        final snap = snapshot.data!.docs;
                        var works = [];
                        for (var data in snap) {
                          if (data.id == homeworkid) {
                            works.add(data);
                          }
                          // works.add(data);
                        }
                        if (works == []) {
                          return SizedBox(
                            height: 100,
                            child: Center(
                                child: Text('Empty',
                                    style:
                                        enFont('semibold', 20, metallicBlue))),
                          );
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: works.length,
                              itemBuilder: (context, index) {
                                return homeworksendContainer(
                                    works[index], deadline);
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
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget homeworksendContainer(
      QueryDocumentSnapshot<Object?> object, var deadline) {
    DateTime deadlineTime = deadline.toDate();
    DateTime sendTime = object['timestamp'].toDate();
    bool isLate = sendTime.compareTo(deadlineTime) == 1 ? true : false;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  works(object['name'], object['url_list'], isLate));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: isLate ? Colors.red.shade400 : Colors.green.shade400),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  object['name'],
                  style: enFont(
                      'semibold', 20, isLate ? Colors.red : Colors.green),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  DateFormat('d MMM yyyy   kk:mm').format(sendTime),
                  style: enFont('semibold', 14,
                      isLate ? Colors.red.shade200 : Colors.green.shade200),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget works(String name, List<dynamic> url, bool isLate) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: SizedBox(
        width: 250,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(name,
                    style:
                        enFont('bold', 20, isLate ? Colors.red : Colors.green)),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: url.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: InkWell(
                          onTap: () {
                            js.context.callMethod('open', [url[index]]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: metallicBlue),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${index + 1}. ${url[index]}',
                                    style: enFont('semibold', 14, metallicBlue),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
