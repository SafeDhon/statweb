// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:statweb/constants.dart';
import 'package:statweb/states/eBook/eBook_class.dart';
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
      height: 630,
      // width: 400,
      child: onChoose
          ? EBookpage(
              pages: pages,
              unit: unit,
              description: description,
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
                  Expanded(
                    child: Text(
                      'Unit ${ebook_units[index].id}',
                      style: enFont('bold', 25, metallicBlue),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      ebook_units[index].description,
                      style: enFont('bold', 20, glaucous),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://drive.google.com/uc?export=view&id=${ebook_units[index].picture}',
                        placeholder: (context, url) => myCircularLoading(),
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