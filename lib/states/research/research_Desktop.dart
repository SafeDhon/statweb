// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;

import '../../constants.dart';

class ResearchDesktop extends StatefulWidget {
  const ResearchDesktop({super.key});

  @override
  State<ResearchDesktop> createState() => _ResearchDesktopState();
}

class _ResearchDesktopState extends State<ResearchDesktop> {
  String search = "";
  List<Map<String, dynamic>> data = [];
  int filter = 0;

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print('Initialize Success');
      await FirebaseFirestore.instance
          .collection('document')
          .snapshots()
          .listen((event) {
        print('snapshot = ${event.docs}');
        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          print('****** map = $map');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    return Container(
      width: 1200,
      height: windowHeight * 0.8,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: metallicBlue,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: TextField(
                      style: enFont('bold', 18, metallicBlue),
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search, size: 30),
                        suffixIconColor: metallicBlue,
                        hintText: 'Search...',
                        hintStyle: enFont('bold', 18, glaucous),
                      ),
                      onChanged: (val) {
                        setState(() {
                          search = val;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    setState(() {
                      filter = 0;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 110,
                    decoration: BoxDecoration(
                      color: filter == 1 ? Colors.transparent : metallicBlue,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: metallicBlue,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Book',
                        style: enFont('bold', 18,
                            filter == 1 ? metallicBlue : Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    setState(() {
                      filter = 1;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 110,
                    decoration: BoxDecoration(
                      color: filter == 0 ? Colors.transparent : metallicBlue,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: metallicBlue,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Report',
                        style: enFont('bold', 18,
                            filter == 0 ? metallicBlue : Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.pink,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('document')
                    .snapshots(),
                builder: (context, snapshots) {
                  return (snapshots.connectionState == ConnectionState.waiting)
                      ? myCircularLoading()
                      : ListView.builder(
                          itemCount: snapshots.data?.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshots.data!.docs[index].data()
                                as Map<String, dynamic>;
                            String type = 'book';
                            if (filter == 0) {
                              type = 'book';
                            } else {
                              type = 'report';
                            }
                            if (search.isEmpty &&
                                data['type']
                                    .toString()
                                    .toLowerCase()
                                    .contains(type)) {
                              return researchBox(
                                data['name_en'],
                                data['name_th'],
                                data['document_url'],
                              );
                            }
                            if ((data['name_en']
                                        .toString()
                                        .toLowerCase()
                                        .contains(search.toLowerCase()) ||
                                    data['name_th']
                                        .toString()
                                        .toLowerCase()
                                        .contains(search.toLowerCase())) &&
                                data['type']
                                    .toString()
                                    .toLowerCase()
                                    .contains(type)) {
                              return researchBox(
                                data['name_en'],
                                data['name_th'],
                                data['document_url'],
                              );
                            }
                            return Container();
                          },
                        );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  InkWell researchBox(String en, String th, String url) {
    return InkWell(
      onTap: () {
        js.context
            .callMethod('open', ['https://drive.google.com/file/d/$url/view']);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: metallicBlue,
                width: 2,
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  en,
                  style: enFont('bold', 22, metallicBlue),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  th,
                  style: thFont('bold', 18, glaucous),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}