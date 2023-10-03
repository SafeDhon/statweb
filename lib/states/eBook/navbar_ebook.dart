import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:statweb/my_icons_icons.dart';

import '../../constants.dart';

class NavBarEBOOK extends StatelessWidget {
  final Function() backwardPress;
  final Function() forwardPress;
  final Function() quizPress;
  final String vdo;
  final String music;
  final Widget quiz;
  final String page;

  const NavBarEBOOK({
    Key? key,
    required this.backwardPress,
    required this.forwardPress,
    required this.quizPress,
    required this.vdo,
    required this.music,
    required this.quiz,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double iconSize = size.width < mobileWidth ? 42 : 50;
    double iconPad = size.width < mobileWidth ? 12 : 15;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: iconSize,
                width: iconSize,
                decoration: BoxDecoration(
                  color: paleYellow,
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      blurRadius: 5,
                      spreadRadius: 0.5,
                      offset: const Offset(2, 2),
                    )
                  ],
                ),
                child: IconButton(
                  color: metallicBlue,
                  icon: const Icon(
                    // Icons.music_note_rounded,
                    MyIcons.icons8_music,
                  ),
                  onPressed: () {
                    js.context.callMethod('open', [music]);
                  },
                ),
              ),
              vdo == '' ? Container() : SizedBox(width: iconPad),
              vdo == ''
                  ? Container()
                  : Container(
                      height: iconSize,
                      width: iconSize,
                      decoration: BoxDecoration(
                        color: paleYellow,
                        borderRadius: BorderRadius.circular(60),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            blurRadius: 5,
                            spreadRadius: 0.5,
                            offset: const Offset(2, 2),
                          )
                        ],
                      ),
                      child: IconButton(
                        color: metallicBlue,
                        icon: const Icon(
                          MyIcons.icons8_youtube,
                          // Icons.video_collection_rounded,
                        ),
                        onPressed: () {
                          js.context.callMethod('open', [vdo]);
                        },
                      ),
                    ),
              SizedBox(width: iconPad),
              Container(
                height: iconSize,
                width: iconSize,
                decoration: BoxDecoration(
                  color: paleYellow,
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      blurRadius: 5,
                      spreadRadius: 0.5,
                      offset: const Offset(2, 2),
                    )
                  ],
                ),
                child: IconButton(
                  color: metallicBlue,
                  icon: const Icon(
                      // Icons.edit_note_rounded,
                      MyIcons.icons8_edit),
                  onPressed: quizPress,
                ),
              ),
            ],
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: backwardPress,
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: metallicBlue,
                    size: size.width < 550 ? 23 : 28,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                    alignment: Alignment.bottomCenter,
                    width: size.width < 550 ? 48 : 53,
                    child: Text(
                      page,
                      style: enFont('bold', 18, metallicBlue),
                    )),
                IconButton(
                  onPressed: forwardPress,
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: metallicBlue,
                    size: size.width < 550 ? 23 : 28,
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: size.width < 550 ? 70 : 80),
        ],
      ),
    );
  }
}
