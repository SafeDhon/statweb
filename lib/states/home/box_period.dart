import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:statweb/constants.dart';
import 'package:statweb/util/login_dialog.dart';

class NextPeriodNav extends StatefulWidget {
  const NextPeriodNav({
    Key? key,
  }) : super(key: key);

  @override
  State<NextPeriodNav> createState() => _NextPeriodNavState();
}

class _NextPeriodNavState extends State<NextPeriodNav> {
  bool onAdd = false;
  DateTime dateTime = DateTime(2023, 8, 20, 00, 00);
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
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return InkWell(
      onTap: () async {
        await getformPrefer().then((value) {
          if (userID == '') {
            showDialog(
              context: context,
              builder: (BuildContext context) => const LoginDialog(),
            ).then((value) async {
              await getformPrefer();
            });
          } else {
            userType == 'student' ? null : pickDateTime();
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: paleYellow,
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
              ? Center(
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: metallicBlue,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Next Period !!',
                            style: periodTextStyle(33),
                          ),
                          Text(description.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: periodTextStyle(22)),
                          Text(
                              DateFormat('kk:mm    d MMM yyyy')
                                  .format(dateTime),
                              style: periodTextStyle(22)),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Image.asset(
                      'assets/images/period.png',
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
    var getPeriod = await FirebaseFirestore.instance
        .collection('period')
        .orderBy('dateTime')
        .get();
    var nextPeriod = getPeriod.docs.last;
    DateTime dateTime = nextPeriod['dateTime'].toDate();
    setState(() {
      description = nextPeriod['description'];
      this.dateTime = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        dateTime.hour,
        dateTime.minute,
      );
    });
  }

  Future addFirebase(String addDescript, DateTime addDateTime) async {
    setState(() => onAdd = true);
    final data = <String, dynamic>{
      'dateTime': addDateTime,
      'description': addDescript,
    };

    FirebaseFirestore.instance
        .collection("period")
        .add(data)
        .then((value) => print('$dateTime $description'));
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
        initialDate: dateTime,
        firstDate: DateTime(2020), // start year
        lastDate: DateTime(2050), // last year
        builder: (context, child) {
          return dateTimePickTheme(context, child);
        },
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: dateTime.hour,
          minute: dateTime.minute,
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
          'Add class description',
          style: enFont('semibold', 18, metallicBlue),
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
              hintStyle: enFont('semibold', 15, beauBlue),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: metallicBlue)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: metallicBlue)),
            ),

            style: enFont('semibold', 15, metallicBlue),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCLE',
              style: enFont('semibold', 15, metallicBlue),
            ),
          ),
          TextButton(
            onPressed: () {
              addFirebase(description, dateTime).then(
                (value) {
                  setState(() {
                    onAdd = false;
                    this.dateTime = dateTime;
                    this.description = description;
                  });
                  Navigator.pop(context);
                },
              );
            },
            child: Text(
              'OK',
              style: enFont('semibold', 15, metallicBlue),
            ),
          ),
        ],
      ),
    );
    // return controller.toString();
  }

  TextStyle periodTextStyle(double fontSize) {
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
}
