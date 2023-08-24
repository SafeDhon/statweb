// ignore_for_file: avoid_web_libraries_in_flutter, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:statweb/constants.dart';
import 'dart:js' as js;

class VDOList extends StatefulWidget {
  const VDOList({super.key});

  @override
  State<VDOList> createState() => _VDOListState();
}

class _VDOListState extends State<VDOList> {
  var vdoList = FirebaseFirestore.instance.collection('video').snapshots();
  final controller = ScrollController();
  final itemController = ItemScrollController();

  var vdos;

  double vdowidth = 300.0;
  double vdoRPadd = 40.0;
  int vdoCurrent = 1;
  int vdoShow = 3;

  // void onListenerController() {
  //   setState(() {});
  // }

  @override
  void initState() {
    // controller.addListener(onListenerController);
    super.initState();
    vdoList = FirebaseFirestore.instance.collection('video').snapshots();
  }

  // @override
  // void dispose() {
  //   controller.removeListener(onListenerController);
  // }

  int item = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.amber,
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Creative Contents',
                style: enFont('bold', 30, metallicBlue),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // item = item - 1 < 0 ? item : item - 1;
                      jumpBackward();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: metallicBlue,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        // item = item + 1 >= newItemCount ? item : item + 1;
                        jumpForward();
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: metallicBlue,
                      )),
                ],
              )
            ],
          ),
          StreamBuilder(
              stream: vdoList,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return myCircularLoading();
                }

                vdos = snapshot.data!.docs;

                return SizedBox(
                  // color: Colors.green,
                  height: 280,
                  width: 1200,
                  child: snapshot.connectionState == ConnectionState.waiting
                      ? myCircularLoading()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: vdos.length,
                          controller: controller,
                          itemBuilder: (context, index) {
                            // final itemOffset = index * 200;
                            // final difference = controller.offset - itemOffset;
                            // final percent = 1 - (difference / (itemOffset / 2));
                            // double oppacity = percent;
                            // if (oppacity > 1.0) oppacity = 1.0;
                            // if (oppacity < 0.0) oppacity = 0.0;
                            // print(oppacity);
                            return Opacity(
                              opacity: 1,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: vdoRPadd, top: 8.0, bottom: 22.0),
                                child: InkWell(
                                  onTap: () {
                                    js.context.callMethod(
                                        'open', [vdos[index]['vdo_url']]);
                                  },
                                  child: Container(
                                    width: vdowidth,
                                    // height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      // color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: glaucous.withOpacity(0.3),
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                          offset: const Offset(4, 4),
                                        )
                                      ],
                                    ),
                                    // height: 150,

                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            topRight: Radius.circular(25.0),
                                          ),
                                          // height: 100,
                                          child: Container(
                                            color: paleYellow,
                                            height: 170,
                                            // child: Image.network(
                                            //   'https://drive.google.com/uc?export=view&id=1bJ1j570QHgyn_N6ZXvXZKUtPLPhB-eNv',
                                            //   // height: 170,
                                            //   fit: BoxFit.cover,
                                            // ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://drive.google.com/uc?export=view&id=${vdos[index]['cover']}",
                                              placeholder: (context, url) =>
                                                  myCircularLoading(),
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 80,
                                          width: double.maxFinite,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(25.0),
                                              bottomRight:
                                                  Radius.circular(25.0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 12),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${vdos[index]['vdo_name']}',
                                                  style: enFont(
                                                      'bold', 22, metallicBlue),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  '${vdos[index]['description']}',
                                                  style: enFont(
                                                      'bold', 14, glaucous),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                );
              }),
        ],
      ),
    );
  }

  Future jumpBackward() async {
    if (controller.hasClients) {
      print("lenght >> ${vdos.length}");
      vdoCurrent - vdoShow < 0
          ? vdoCurrent = 1
          : vdoCurrent = vdoCurrent - vdoShow;
      print("current >> $vdoCurrent");
      double item = (vdoCurrent - 1) * (vdowidth + vdoRPadd);
      print(item);
      controller.animateTo(
        item,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeIn,
      );
    }
  }

  Future jumpForward() async {
    if (controller.hasClients) {
      print("lenght >> ${vdos.length}");
      vdoCurrent + vdoShow > vdos.length
          ? vdoCurrent
          : vdoCurrent = vdoCurrent + vdoShow;
      print("current >> $vdoCurrent");
      double item = (vdoCurrent - 1) * (vdowidth + vdoRPadd);
      print(item);
      controller.animateTo(
        item,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeIn,
      );
    }
  }
}
