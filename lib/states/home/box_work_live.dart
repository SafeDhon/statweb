import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statweb/constants.dart';
import 'package:statweb/states/home/home.dart';
import 'package:statweb/states/home/upload_dialog.dart';
import 'package:statweb/util/login_dialog.dart';

class MyWorkLiveNav extends StatefulWidget {
  const MyWorkLiveNav({super.key});

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
      userType = preferences.getString('type')!;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  ? UploadDialog(userID: userID, homeworkID: homeworkID)
                  : manageDialog(),
            );
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: metallicBlue,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(4, 4),
            )
          ],
        ),
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
                          const Text(
                            'Home work Live !!',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Quicksand',
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                              shadows: [
                                Shadow(
                                  blurRadius: 5.0,
                                  color: Colors.black54,
                                  offset: Offset(3.0, 3.0),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            description.toString(),
                            style: homeworkTextStyle(28),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text('Assign',
                                        style: homeworkTextStyle(20)),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                       DateFormat(':  d MMM yyyy').format(assign),
                                        style: homeworkTextStyle(20)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                        DateFormat('kk:mm').format(assign),
                                        style: homeworkTextStyle(20)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text('Deadline',
                                        style: homeworkTextStyle(20)),
                                  ),
                                 Expanded(
                                    flex: 4,
                                    child: Text(
                                       DateFormat(':  d MMM yyyy').format(deadline),
                                        style: homeworkTextStyle(20)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                        DateFormat('kk:mm').format(deadline),
                                        style: homeworkTextStyle(20)),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Image.asset(
                          'assets/images/hwlive.png',
                          height: 500,
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

  TextStyle homeworkTextStyle(double fontSize) {
    return TextStyle(
      color: Colors.white,
      fontFamily: 'Quicksand',
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      shadows: const [
        Shadow(
          blurRadius: 5.0,
          color: Colors.black54,
          offset: Offset(1.0, 1.0),
        ),
      ],
    );
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
            child: Text(
              'Add new homework',
              style: enFont('bold', 18, Colors.white),
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
          print(homeworkID);
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
}
