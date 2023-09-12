import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;
import '../../constants.dart';

class VDOGrid extends StatefulWidget {
  const VDOGrid({super.key});

  @override
  State<VDOGrid> createState() => _VDOGridState();
}

class _VDOGridState extends State<VDOGrid> {
  var vdoList = FirebaseFirestore.instance.collection('video').snapshots();
  var vdos;

  @override
  void initState() {
    super.initState();
    vdoList = FirebaseFirestore.instance.collection('video').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Creative Contents', style: enFont('bold', 30, metallicBlue)),
        const SizedBox(height: 10),
        StreamBuilder(
            stream: vdoList,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(height: 200, child: myCircularLoading());
              }

              vdos = snapshot.data!.docs;

              return snapshot.connectionState == ConnectionState.waiting
                  ? SizedBox(height: 200, child: myCircularLoading())
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 500,
                        childAspectRatio: 16 / 12,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        // mainAxisExtent: 300
                      ),
                      primary: false,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: vdos.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {

                               js.context.callMethod(
                                        'open', [vdos[index]['vdo_url']]);
                          },
                          child: Container(
                            // height: 100,
                            // width: 100,
                            decoration: BoxDecoration(
                              // color: metallicBlue,
                              borderRadius: BorderRadius.circular(20),
                              // border:
                              //     Border.all(width: 2, color: metallicBlue),
                              boxShadow: [
                                BoxShadow(
                                  color: glaucous.withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: const Offset(4, 4),
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Container(
                                      color: paleYellow,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://drive.google.com/uc?export=view&id=${vdos[index]['cover']}",
                                        placeholder: (context, url) =>
                                            myCircularLoading(),
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          );
                                        },
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: Text(
                                            'Error loading',
                                            style: enFont('bold', 15,
                                                Colors.grey.shade400),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: double.maxFinite,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${vdos[index]['vdo_name']}',
                                              style: enFont(
                                                  'bold', 22, metallicBlue),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              '${vdos[index]['description']}',
                                              style:
                                                  enFont('bold', 14, glaucous),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            }),
      ],
    );
  }
}
