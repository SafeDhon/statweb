import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:statweb/constants.dart';

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
    getFireBaseDateTime().then((value) => print('get time'));
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Next Period !!',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                        fontSize: 33,
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
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                        fontSize: 22,
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
                      '$hours:$minutes  ${dateTime.day}/${dateTime.month}/${dateTime.year}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                        fontSize: 22,
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
                  ],
                ),
              ),
              Expanded(
                  child: Image.asset(
                'assets/images/calculator.png',
                height: 500,
              )),
            ],
          ),
        ),
      ),
    );
  }

  Future getFireBaseDateTime() async {
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
}
