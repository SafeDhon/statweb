import 'package:flutter/material.dart';

import '../../constants.dart';

class NavBarEBOOK extends StatelessWidget {
  final Function() backwardPress;
  final Function() forwardPress;
  final String vdo;
  final String music;
  final Widget quiz;
  final String page;

  const NavBarEBOOK({
    Key? key,
    required this.backwardPress,
    required this.forwardPress,
    required this.vdo,
    required this.music,
    required this.quiz,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
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
                  icon: const Icon(Icons.music_note_rounded),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 15),
              Container(
                height: 50,
                width: 50,
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
                  icon: const Icon(Icons.video_collection_rounded),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 15),
              Container(
                height: 50,
                width: 50,
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
                  icon: const Icon(Icons.edit_note_rounded),
                  onPressed: () {},
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
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                    alignment: Alignment.bottomCenter,
                    width: 53,
                    child: Text(
                      page,
                      style: enFont('bold', 18, metallicBlue),
                    )),
                IconButton(
                  onPressed: forwardPress,
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: metallicBlue,
                    size: 28,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 80),
        ],
      ),
    );
  }
}
