import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:statweb/constants.dart';

class ManagePeriod extends StatefulWidget {
  const ManagePeriod({super.key});

  @override
  State<ManagePeriod> createState() => _ManagePeriodState();
}

class _ManagePeriodState extends State<ManagePeriod> {
  bool onEdit = false;
  bool onAdd = false;
  DateTime dateTime = DateTime.now();
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
                        .collection('period')
                        .orderBy('dateTime')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData  && snapshot.data!.docs.isNotEmpty) {
                        final snap = snapshot.data!.docs;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snap.length,
                            itemBuilder: (context, index) {
                              return periodContainer(
                                  snap[index], snap[index].id);
                            });
                      } else {
                        return SizedBox(
                    height: 100,
                          child: Center(
                            child: Text(
                              'No Period',
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
                    Expanded(child: addPeriodButt()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget periodContainer(
      QueryDocumentSnapshot<Object?> object, String homeworkID) {
    // bool onActivate = object['activate'];
    DateTime dateTime = object['dateTime'].toDate();
    String dateTimeShow = DateFormat('d MMMM kk:mm').format(dateTime);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: onEdit
            ? () {}
            : () {
                // print(object.id);
                showDialog(
                    context: context,
                    builder: (BuildContext context) => descriptionDialog(
                        dateTime, object['description'].toString()));
              },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: metallicBlue,
            ),
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
                        style: enFont(
                          'semibold',
                          20,
                          metallicBlue,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        dateTimeShow,
                        style: enFont('semibold', 14, glaucous),
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
                              .collection('period')
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

  Widget addPeriodButt() {
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
