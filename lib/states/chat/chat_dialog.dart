import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statweb/constants.dart';

class ChatDialog extends StatefulWidget {
  final String userID;
  const ChatDialog({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<ChatDialog> createState() => _ChatDialogState();
}

class _ChatDialogState extends State<ChatDialog> {
  bool onLoading = false;
  String userID = '';
  String userName = '';
  String userSur = '';
  String userType = '';
  String previousU = '';
  final TextEditingController _message = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> getformPrefer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userID = preferences.getString('id')!;
      userName = preferences.getString('name')!;
      userSur = preferences.getString('surname')!;
      userType = preferences.getString('type')!;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() => onLoading = true);
    getformPrefer().then((value) => setState(() => onLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final chatList = [];
    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: SizedBox(
        width: 350,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Column(
            children: [
              roomHeader(),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('chat')
                      .orderBy("time", descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        itemCount: snapshot.data!.docs.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Container(
                              height: 20,
                            );
                          }
                          Map<String, dynamic> map =
                              snapshot.data!.docs[index - 1].data()
                                  as Map<String, dynamic>;
                          try {
                            Map<String, dynamic> previousmap =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            previousU = previousmap['sendby'];
                          } catch (e) {
                            previousU = '';
                          }

                          chatList.add(map);

                          return messages(size, map, previousU, context);
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              inputChatBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map, String previousUser,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: map['type'] == "text"
          ? textBox(size, map, previousUser)
          : imageBox(size, map, previousUser),
    );
  }

  Widget textBox(Size size, Map<String, dynamic> map, String previousUser) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        map['sendby'] == userID
            ? Container(height: 3)
            : previousUser == map['sendby']
                ? Container(height: 3)
                : Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 1),
                    child: Text('${map['sendby']} ${map['sendby_name']}',
                        style: enFont('bold', 10, glaucous)),
                  ),
        Container(
          width: size.width,
          alignment: map['sendby'] == userID
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            // margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: map['sendby'] == userID ? metallicBlue : water,
            ),
            child: Text(
              map['message'],
              style: thFont(
                'bold',
                16,
                map['sendby'] == userID ? Colors.white : metallicBlue,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget imageBox(Size size, Map<String, dynamic> map, String previousUser) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        map['sendby'] == userID
            ? Container(height: 3)
            : previousUser == map['sendby']
                ? Container(height: 3)
                : Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 1),
                    child: Text('${map['sendby']} ${map['sendby_name']}',
                        style: enFont('bold', 10, glaucous)),
                  ),
        Container(
          alignment: map['sendby'] == userID
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => imageShow(map['message']));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color:
                    map['sendby'] == userID ? beauBlue : Colors.grey.shade300,
                child: map['message'] == ""
                    ? SizedBox(
                        width: 150,
                        height: 150,
                        child: myCircularLoading(),
                      )
                    : Image.network(
                        map['message'],
                        fit: BoxFit.cover,
                        width: 170,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget inputChatBox() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: metallicBlue, width: 2),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _message,
                        style: thFont('bold', 16, metallicBlue),
                        decoration: InputDecoration(
                            hintText: "Type Message ....",
                            hintStyle: thFont('bold', 16, glaucous),
                            border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      onPressed: () => getImage(),
                      icon: Icon(Icons.image, color: metallicBlue),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: onSendMessage,
              icon: Icon(Icons.send, color: metallicBlue),
            )
          ],
        ),
      ),
    );
  }

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": userID,
        "sendby_name": userName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };
      _message.clear();
      await _firestore.collection('chat').add(messages);
    } else {}
  }

  Future<void> getImage() async {
    Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    if (bytesFromPicker != null) {
      uploadImage(bytesFromPicker);
    } else {}
  }

  Future<void> uploadImage(Uint8List bytesPick) async {
    int status = 1;
    Timestamp now = Timestamp.now();

    await _firestore.collection('chat').doc(now.toString()).set({
      "sendby": userID,
      "sendby_name": userName,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });

    final storageRef = FirebaseStorage.instance.ref('chatFiles/$now.png');
    final uploadTask = storageRef.putData(bytesPick);
    final takeSnapshot = await uploadTask.catchError((error) async {
      await _firestore.collection('chat').doc(now.toString()).delete();
      status = 0;
    });

    // _scrollController.animateTo(
    //   _scrollController.position.minScrollExtent,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeOut,
    // );

    if (status == 1) {
      String url = await takeSnapshot.ref.getDownloadURL();
      await _firestore
          .collection('chat')
          .doc(now.toString())
          .update({"message": url});
    }
  }

  Widget roomHeader() {
    return Container(
      height: 50,
      width: double.maxFinite,
      decoration: BoxDecoration(color: metallicBlue),
      child: Center(
        child: Text(
          'Class CS 243',
          style: enFont('bold', 25, Colors.white),
        ),
      ),
    );
  }

  Widget imageShow(String url) {
    return Dialog(
      child: Image.network(url, fit: BoxFit.cover),
    );
  }
}
