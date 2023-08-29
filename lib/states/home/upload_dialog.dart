import 'dart:html';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:statweb/constants.dart';

class UploadDialog extends StatefulWidget {
  final String userID;
  final String homeworkID;

  const UploadDialog({
    Key? key,
    required this.userID,
    required this.homeworkID,
  }) : super(key: key);

  @override
  State<UploadDialog> createState() => _UploadDialogState();
}

class _UploadDialogState extends State<UploadDialog> {
  // List<File> files = [];
  bool onUpload = false;
  List<dynamic> files = [];
  List<String> downloadUrls = [];
  String status = '';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: SizedBox(
        width: 250,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text('Upload Homework',
                    style: enFont('bold', 25, metallicBlue)),

                files.isEmpty ? emptyBox() : filesList(),
                // Text(widget.userID),
                // Text(widget.homeworkID),
                getFilesBox(),
                files.isEmpty ? Container() : uploadTofirebaseBox(),
                status != ''
                    ? Text(
                        status,
                        style: enFont('semibold', 12, Colors.red),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emptyBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        height: 200,
        padding: EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: water,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Text(
          'Please upload your homework',
          style: enFont('bold', 12, Colors.grey),
        ),
      ),
    );
  }

  Widget filesList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ListView.builder(
          itemCount: files.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  // height: 30,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(width: 2, color: glaucous)),
                  child: Text(
                    files[index].fileName,
                    overflow: TextOverflow.ellipsis,
                    style: enFont('semibold', 12, glaucous),
                  ),
                ),
              )),
    );
  }

  Widget getFilesBox() {
    return InkWell(
      onTap: () {
        getFiles();
      },
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: glaucous,
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Text(
          'Upload',
          style: enFont('bold', 18, Colors.white),
        ),
      ),
    );
  }

  Future<void> getFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      // MyFileClass? file;
      // file?.unit8 = result.files.first.bytes;
      // file?.fileName = result.files.first.name;
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;
      MyFileClass file = MyFileClass(uint8: fileBytes, fileName: fileName);
      setState(() {
        // files.add(fileName);
        files.add(file);
        // print(files);
        // files = result.paths.map((path) => File(path!)).toList();
      });
    } else {
      // User canceled the picker
    }
  }

  Widget uploadTofirebaseBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () async {
          setState(() => onUpload = true);
          downloadUrls.clear();
          for (int i = 0; i < files.length; i++) {
            String url =
                await uploadToFirebase(files[i].fileName, files[i].uint8);
            downloadUrls.add(url);
            if (i == files.length - 1) {
              upToDatabase(downloadUrls, widget.userID, widget.homeworkID)
                  .then((value) {
                setState(() => onUpload = false);
                Navigator.pop(context);
              }).catchError((e) {
                setState(() {
                  onUpload = false;
                  status = 'Upload failed';
                });
              });
            }
          }
          // uploadToFirebase();
        },
        child: Container(
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: metallicBlue,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Center(
            child: onUpload
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Send',
                    style: enFont('bold', 18, Colors.white),
                  ),
          ),
        ),
      ),
    );
  }

  Future<String> uploadToFirebase(String filename, Uint8List filebytes) async {
    Timestamp now = Timestamp.now();
    final storageRef = FirebaseStorage.instance.ref('homeworks/$now$filename');
    final uploadTask = storageRef.putData(filebytes);
    // await FirebaseStorage.instance.ref('homeworks/$filename').putData(filebytes);
    final takeSnapshot = await uploadTask.whenComplete(() => null);
    String url = await takeSnapshot.ref.getDownloadURL();
    return url;
  }

  Future<void> upToDatabase(
      List<String> urlFiles, String userID, String homeworkID) async {
    final data = {"url_list": urlFiles};
    FirebaseFirestore.instance
        .collection('user')
        .doc(userID)
        .collection('homeworks')
        .doc(homeworkID)
        .set(data);
  }
}

class MyFileClass {
  Uint8List? uint8;
  String fileName;
  MyFileClass({
    this.uint8,
    required this.fileName,
  });
}
