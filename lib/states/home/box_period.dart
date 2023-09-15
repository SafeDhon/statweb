import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_shadow/simple_shadow.dart';

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
    double widthUI = MediaQuery.of(context).size.width;
    double headFontSize = widthUI < 1150 ? 25 : 35;
    double descriptFontSize = widthUI < 1150 ? 22 : 25;
    double subFontSize = widthUI < 1150 ? 18 : 20;
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
            userType == 'student'
                ? showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        descriptionDialog(dateTime, description.toString()),
                  )
                : pickDateTime();
          }
        });
      },
      child: Container(
        decoration: homeBox(paleYellow1),
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
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textHomeBox('Next Period !!', headFontSize),
                          // Text(
                          //   'Next Period !!',
                          //   style: periodTextStyle(headFontSize),
                          // ),
                          textHomeBox(description.toString(), descriptFontSize),
                          // Text(description.toString(),
                          //     overflow: TextOverflow.ellipsis,
                          //     maxLines: 1,
                          //     style: periodTextStyle(descriptFontSize)),
                          textHomeBox(
                              DateFormat('kk:mm    d MMM yyyy')
                                  .format(dateTime),
                              subFontSize),
                          // Text(
                          //     DateFormat('kk:mm    d MMM yyyy')
                          //         .format(dateTime),
                          //     style: periodTextStyle(subFontSize)),
                        ],
                      ),
                    ),
                    Expanded(
                        child: SimpleShadow(
                      opacity: 0.9, // Default: 0.5
                      color: Colors.black, // Default: Black
                      offset: const Offset(0, 0), // Default: Offset(2, 2)
                      sigma: 2,
                      child: Image.asset(
                        'assets/images/period.png',
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

  Widget descriptionDialog(DateTime date, String description) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Next Period', style: enFont('bold', 28, metallicBlue)),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer_sharp),
                Text(
                  DateFormat(size.width < mobileWidth
                          ? ' kk:mm  d/MMM/yy'
                          : '  kk:mm  d MMMM yyyy')
                      .format(date),
                  style: enFont('semibold', 20, glaucous),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              description,
              style: thFont('bold', 20, metallicBlue),
            ),
          ],
        ),
      )),
    );
  }
}
