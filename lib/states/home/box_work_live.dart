import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statweb/constants.dart';
import 'package:statweb/states/home/home.dart';

class MyWorkLiveNav extends StatefulWidget {
  const MyWorkLiveNav({super.key});

  @override
  State<MyWorkLiveNav> createState() => _MyWorkLiveNavState();
}

class _MyWorkLiveNavState extends State<MyWorkLiveNav> {
  bool onAdd = false;
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
          } else {
            userType == 'student' ? null : pickDateTime();
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
                          Text(description.toString(),
                              style: homeworkTextStyle(28),
                              overflow: TextOverflow.ellipsis,),
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
                                        ':  ${assign.day}/${assign.month}/${assign.year}',
                                        style: homeworkTextStyle(20)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                        '${assign.hour.toString().padLeft(2, '0')}.${assign.minute.toString().padLeft(2, '0')}',
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
                                        ':  ${deadline.day}/${deadline.month}/${deadline.year}',
                                        style: homeworkTextStyle(20)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                        '${deadline.hour.toString().padLeft(2, '0')}.${deadline.minute.toString().padLeft(2, '0')}',
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
    var homework = getHomework.docs.last;
    DateTime deadline = homework['deadline'].toDate();
    DateTime assign = homework['assign'].toDate();
    setState(() {
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
          offset: Offset(3.0, 3.0),
        ),
      ],
    );
  }
}
