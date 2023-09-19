// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:statweb/constants.dart';
import 'package:statweb/states/eBook/eBook_class.dart';
import 'package:statweb/states/eBook/ebook_Test.dart';
import 'package:statweb/states/eBook/ebook_page.dart';

class EBookDeskTop extends StatefulWidget {
  const EBookDeskTop({super.key});

  @override
  State<EBookDeskTop> createState() => _EBookDeskTopState();
}

class _EBookDeskTopState extends State<EBookDeskTop> {
  bool onChoose = false;
  List<EBookPage> pages = [];
  String unit = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 630,
      // width: 400,
      child: onChoose
          // ? EBookpage(
          //     onBack: () => setState(() => onChoose = false),
          //     pages: pages,
          //     unit: unit,
          //     description: description,
          //   )
          ? EbookPageTest(
              unit: int.parse(unit),
              description: description,
              onBack: () => setState(() => onChoose = false),
            )
          : unitGrid(),
    );
  }

  Widget unitGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      primary: false,
      shrinkWrap: true,
      itemCount: ebook_units.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              pages = ebook_units[index].pages;
              unit = ebook_units[index].id.toString();
              description = ebook_units[index].description;
              onChoose = true;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                // color: metallicBlue,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 2, color: metallicBlue)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Unit ${ebook_units[index].id}',
                    style: enFont('bold', 27, metallicBlue),
                  ),
                  Text(
                    ebook_units[index].description,
                    style: enFont('bold', 20, glaucous),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://firebasestorage.googleapis.com/v0/b/reportstatweb.appspot.com/o/${ebook_units[index].picture}',
                        placeholder: (context, url) => myCircularLoading(),
                        imageBuilder: (context, imageProvider) {
                          return SimpleShadow(
                            opacity: 0.9, // Default: 0.5
                            color: Colors.black, // Default: Black
                            offset: const Offset(0, 0), // Default: Offset(2, 2)
                            sigma: 2, // Default: 2
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  // fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) => Center(
                          child: Text(
                            'Error loading',
                            style: enFont('bold', 15, Colors.grey.shade400),
                          ),
                        ),
                      ),
                    ),
                    // child: Image.asset(
                    //   '/images/illustrations/${ebook_units[index].picture}',
                    //   fit: BoxFit.fill,
                    //   errorBuilder: (context, url, error) => Center(
                    //     child: Text(
                    //       'Error loading',
                    //       style: enFont('bold', 15, Colors.grey.shade400),
                    //     ),
                    //   ),
                    //   frameBuilder: (context, child, frame,
                    //           wasSynchronouslyLoaded) =>
                    //       SimpleShadow(
                    //           opacity: 0.9, // Default: 0.5
                    //           color: Colors.black, // Default: Black
                    //           offset:
                    //               const Offset(0, 0), // Default: Offset(2, 2)
                    //           sigma: 2,
                    //           child: child),
                    // ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> updateDisplayName() async {
    String user = '7617';
    String password = '063720';
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: '$user@gmail.com', password: password)
        .then((value) async {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(user);
    });
  }
}


// 'https://drive.google.com/uc?export=view&id=${ebook_units[index].picture}',