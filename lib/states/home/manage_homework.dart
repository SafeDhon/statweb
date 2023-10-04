// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:statweb/constants.dart';
import 'dart:js' as js;

class ManageHomeWorkDialog extends StatefulWidget {
  const ManageHomeWorkDialog({super.key});

  @override
  State<ManageHomeWorkDialog> createState() => _ManageHomeWorkDialogState();
}

class _ManageHomeWorkDialogState extends State<ManageHomeWorkDialog> {
  bool onEdit = false;
  bool onAdd = false;
  DateTime assign = DateTime.now();
  DateTime deadline = DateTime.now();
  String? description = 'No Description';
  @override
  Widget build(BuildContext context) {
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
                        .orderBy('assign')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        final snap = snapshot.data!.docs;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snap.length,
                            itemBuilder: (context, index) {
                              return homeworkContainer(
                                  snap[index], snap[index].id);
                            });
                      } else {
                        return SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              'No Homework',
                              style: enFont('bold', 25, Colors.grey.shade400),
                            ),
                          ),
                        );
                      }
                    }),
                Row(
                  children: [
                    Expanded(child: editButton()),
                    const SizedBox(width: 5),
                    Expanded(child: addHomeworkButt()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget editButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: InkWell(
        onTap: () {
          setState(() => onEdit = !onEdit);
        },
        child: Container(
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: onEdit ? paleYellow1 : glaucous,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  onEdit ? Icons.done_rounded : Icons.edit_rounded,
                  color: onEdit ? metallicBlue : Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  onEdit ? 'Finish' : 'Edit',
                  style:
                      enFont('bold', 18, onEdit ? metallicBlue : Colors.white),
                ),
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
          height: 38,
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
                  'New',
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
    bool onActivate = object['activate'];
    DateTime assign = object['assign'].toDate();
    DateTime deadline = object['deadline'].toDate();
    String assignShow = DateFormat('d MMM kk:mm').format(assign);
    String deadlineShow = DateFormat('d MMM kk:mm').format(deadline);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: onEdit
            ? () async {
                await FirebaseFirestore.instance
                    .collection('homework')
                    .doc(homeworkID)
                    .update({'activate': !onActivate});
              }
            : () {
                // print(object.id);
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        homeworkSendDialog(object.id, object['deadline']));
              },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: onActivate ? Colors.green.shade700 : metallicBlue),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${object['description']}',
                        style: enFont('semibold', 20,
                            onActivate ? Colors.green.shade600 : metallicBlue),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        '$assignShow - $deadlineShow',
                        style: enFont('semibold', 14,
                            onActivate ? Colors.green.shade300 : glaucous),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
                onEdit
                    ? IconButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('homework')
                              .doc(homeworkID)
                              .delete();
                        },
                        icon: Icon(
                          Icons.cancel_rounded,
                          color: Colors.grey.shade500,
                        ),
                      )
                    : Container()
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return myCircularLoading();
                      }
                      if (snapshot.hasData || snapshot.data!.docs.isNotEmpty) {
                        final snap = snapshot.data!.docs;
                        var works = [];
                        for (var data in snap) {
                          if (data.id == homeworkid) {
                            works.add(data);
                          }
                          // works.add(data);
                        }
                        if (works.isEmpty) {
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
      'activate': false,
    };

    FirebaseFirestore.instance
        .collection("homework")
        .add(data)
        .then((value) => setState(() => onAdd = false));
  }
}
