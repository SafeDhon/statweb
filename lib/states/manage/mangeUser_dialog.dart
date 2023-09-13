// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:statweb/states/manage/infoUser_dialog.dart';

import '../../constants.dart';

class ManageUserDialog extends StatefulWidget {
  final String currentUserID;
  final String currentUserPassword;

  const ManageUserDialog({
    Key? key,
    required this.currentUserID,
    required this.currentUserPassword,
  }) : super(key: key);

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
        // SingleChildScrollView
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
                            primary: false,
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
                    print('>>>>>>>>>>>>>>>>>> ${widget.currentUserID}');
                    print('>>>>>>>>>>>>>>>>>> ${widget.currentUserPassword}');
                    deleteUser(object.id, object['password'])
                        .then((value) async {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: '${widget.currentUserID}@gmail.com',
                              password: widget.currentUserPassword)
                          .then(
                              (value) => print('..................... ReAuth'));
                    }).catchError((e) async {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: '${widget.currentUserID}@gmail.com',
                              password: widget.currentUserPassword)
                          .then(
                              (value) => print('..................... ReAuth'));
                    });
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

  Future deleteUser(String id, String password) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .delete()
        .then((value) {
      final userToDelete = FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: '$id@gmail.com', password: password)
          .then((value) async {
        final user = FirebaseAuth.instance.currentUser!;
        await user.delete();
      });
    });
  }

  Widget addUserButt() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
