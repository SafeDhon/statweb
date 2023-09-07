// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:statweb/states/manage/infoUser_dialog.dart';
import '../../constants.dart';

class ManageUserDialog extends StatefulWidget {
  const ManageUserDialog({super.key});

  @override
  State<ManageUserDialog> createState() => _ManageUserDialogState();
}

class _ManageUserDialogState extends State<ManageUserDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: SizedBox(
        width: 280,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('user')
                        .where('typeuser', isEqualTo: 'student')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final snap = snapshot.data!.docs;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snap.length,
                            itemBuilder: (context, index) {
                              return userContainer(snap[index]);
                            });
                      } else {
                        return const SizedBox();
                      }
                    }),
                addUserButt(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userContainer(QueryDocumentSnapshot<Object?> object) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {},
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${object['name']} ${object['surname']}',
                        style: enFont('semibold', 20, metallicBlue),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        '${object.id}   ${object['year']}-${object['section']}',
                        style: enFont('semibold', 14, glaucous),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('user')
                        .doc(object.id)
                        .delete();
                  },
                  icon: Icon(
                    Icons.cancel_rounded,
                    color: Colors.grey.shade600,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addUserButt() {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 10.0),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => InfoUserDialog());
        },
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
                  'Create User',
                  style: enFont('bold', 18, Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
