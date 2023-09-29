import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_shadow/simple_shadow.dart';

import 'package:statweb/constants.dart';
import 'package:statweb/states/home/manage_period.dart';

class NextPeriodNav extends StatefulWidget {
  const NextPeriodNav({
    Key? key,
  }) : super(key: key);

  @override
  State<NextPeriodNav> createState() => _NextPeriodNavState();
}

class _NextPeriodNavState extends State<NextPeriodNav> {
  bool onAdd = false;
  DateTime dateTime = DateTime.now();
  String? description = 'No Description';
  String userID = '';
  String userType = '';
  var periods = [];

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
          if (userType == 'student' || userType == '') {
            if (periods.isNotEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    descriptionDialog(dateTime, description.toString()),
              );
            }
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) => const ManagePeriod(),
            );
            // pickDateTime();
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
                      // child: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     textHomeBox('Next Period !!', headFontSize),
                      //     textHomeBox(description.toString(), descriptFontSize),
                      //     textHomeBox(
                      //         dateTime.year == 0
                      //             ? "Time :   -"
                      //             : DateFormat('d MMM yyyy   kk:mm')
                      //                 .format(dateTime),
                      //         subFontSize),
                      //   ],
                      // ),
                      child: periodBuild(),
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

  Widget periodBuild() {
    double widthUI = MediaQuery.of(context).size.width;
    double headFontSize = widthUI < 1150 ? 25 : 35;
    double descriptFontSize = widthUI < 1150 ? 22 : 25;
    double subFontSize = widthUI < 1150 ? 18 : 20;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('period')
            .orderBy('dateTime')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
            return myCircularLoading();
          }
          if (snapshot.hasData) {
            final snap = snapshot.data!.docs;
            // var periods = [];
            for (var data in snap) {
              if (data['dateTime'].compareTo(Timestamp.now()) == 1) {
                periods.add(data);
              }
            }
            if (periods.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textHomeBox('Next Period !!', headFontSize),
                  textHomeBox(
                      periods[0]['description'].toString(), descriptFontSize),
                  textHomeBox(
                      DateFormat('d MMM yyyy   kk:mm')
                          .format(periods[0]['dateTime'].toDate()),
                      subFontSize),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textHomeBox('Next Period !!', headFontSize),
                  textHomeBox("There isn't period", descriptFontSize),
                ],
              );
            }
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                textHomeBox('Next Period !!', headFontSize),
                textHomeBox("There isn't period", descriptFontSize),
              ],
            );
          }
        });
  }
}
