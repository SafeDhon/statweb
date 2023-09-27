import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_shadow/simple_shadow.dart';

import 'package:statweb/constants.dart';
import 'package:statweb/my_icons_icons.dart';

import 'package:statweb/states/chat/chat_dialog.dart';
import 'package:statweb/states/eBook/eBookDesktop.dart';

import 'package:statweb/states/manage/mangeUser_dialog.dart';
import 'package:statweb/states/quiz/quiz_units.dart';
import 'package:statweb/states/research/research_Desktop.dart';
import 'package:statweb/states/score/score_mobile.dart';
import 'package:statweb/states/score/score_test.dart';
import 'package:statweb/util/login_top.dart';
import 'package:statweb/util/logout_dialog.dart';

import '../states/home/home_desktop.dart';
import '../states/score/score_desktop.dart';
import '../util/header.dart';
import '../util/login_dialog.dart';

class ResponsivePage extends StatefulWidget {
  const ResponsivePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ResponsivePage> createState() => _ResponsivePageState();
}

class _ResponsivePageState extends State<ResponsivePage> {
  String userTest = '';
  bool isLoading = true;
  bool isDialogLoading = false;
  ScrollController mainpageController = ScrollController();

  var currentPage = DrawerSections.home;
  String currentHeader = 'Home';
  String userID = '';
  String userName = '';
  String userSur = '';
  String userType = '';
  String userPass = '';

  @override
  void initState() {
    super.initState();
    // addData();
    getformPrefer();
  }

  Future<void> addData() async {
    await FirebaseFirestore.instance.collection('ebooks').doc('721').set({
      "page": 21,
      "unit": 7,
      "quiz": 7,
      "music": '',
      "vdo": '',
      "contain": '',
    });
  }

  Future<void> getformPrefer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userID = preferences.getString('id')!;
      userName = preferences.getString('name')!;
      userSur = preferences.getString('surname')!;
      userType = preferences.getString('type')!;
      userPass = preferences.getString('password')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthUI = MediaQuery.of(context).size.width;
    dynamic contain;
    if (currentPage == DrawerSections.home) {
      contain = const HomeDesktop();
      currentHeader = 'Home';
    } else if (currentPage == DrawerSections.eBook) {
      contain = const EBookDeskTop();
      currentHeader = 'E-Book';
    } else if (currentPage == DrawerSections.quiz) {
      contain = const QuizUnit();
      currentHeader = 'Quiz';
    } else if (currentPage == DrawerSections.score) {
      contain =
          // widthUI < mobileWidth ? const ScoreMobile() : const ScoreDesktop();
          contain = const ScoreTest();
      currentHeader = 'Score';
    } else if (currentPage == DrawerSections.research) {
      contain = const ResearchDesktop();
      currentHeader = 'Research';
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: widthUI < tabletWidth
          ? myAppBar(currentHeader, [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Center(
                  child: userID == ''
                      ? IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const LoginDialog(),
                            ).then((value) async {
                              await getformPrefer();
                            });
                          },
                          icon: const Icon(
                            MyIcons.user1,
                            color: Colors.white,
                            size: 25,
                          ))
                      : Text(
                          widthUI < 501
                              ? userID
                              : '$userID  $userName ${userSur[0]}.',
                          style: enFont('semibold', 18, Colors.white),
                        ),
                ),
              )
            ])
          : null,
      drawer: myDrawer(),
      body: Row(
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widthUI < tabletWidth ? Container() : myDrawer(),
          // Expanded(child: Container()),
          Expanded(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  color: Colors.white,
                  child: SizedBox(
                    // color: Colors.pink.shade400,
                    width: widthUI < mobileWidth ? null : 1080,
                    child: RawScrollbar(
                      mainAxisMargin: 6,
                      controller: mainpageController,
                      thumbColor: glaucous.withOpacity(0.6),
                      radius: const Radius.circular(20),
                      thumbVisibility: true,
                      thickness: 8,
                      scrollbarOrientation: ScrollbarOrientation.right,

                      // isAlwaysShown: true,
                      // trackVisibility: true,
                      // interactive: true,
                      // showTrackOnHover: true,
                      // hoverThickness: 100,

                      child: SingleChildScrollView(
                        controller: mainpageController,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: widthUI < tabletWidth ? 8 : 12,
                            bottom: widthUI < tabletWidth ? 8 : 12,
                            left: 10.0,
                            right: 20.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              widthUI < tabletWidth
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          currentHeader,
                                          style: enFont(
                                              'semibold', 50, metallicBlue),
                                        ),
                                        // widget.user == ''
                                        userID == ''
                                            ? LoginTopButton(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        const LoginDialog(),
                                                  ).then((value) async {
                                                    await getformPrefer();
                                                  });
                                                },
                                              )
                                            : MyHeader(
                                                user_name:
                                                    '$userID  $userName $userSur',
                                              ),
                                      ],
                                    ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: widthUI < tabletWidth ? 4 : 16),
                                  child: contain),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                chatButton(),
              ],
            ),
          ),
          // Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget chatButton() {
    return Positioned(
      bottom: 10,
      right: 10,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: metallicBlue,
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
          ),
          const Positioned(
            top: 14,
            left: 14,
            child: Icon(
              MyIcons.chat,
              size: 28,
              color: Colors.white,
            ),
          ),
          IconButton(
            iconSize: 45,
            color: Colors.transparent,
            icon: const Icon(
              MyIcons.chat_2,
            ),
            onPressed: () {
              if (userID == '') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const LoginDialog(),
                ).then((value) async {
                  await getformPrefer();
                });
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => ChatDialog(
                          userID: userID,
                        ));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget myDrawer() {
    return Drawer(
      width: 250,
      backgroundColor: metallicBlue,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            // padding: const EdgeInsetsDirectional.only(top: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Image.asset(
                        'assets/icons/logo.png',
                        // width: 50,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "STAT",
                          style: enFont('bold', 35, Colors.white),
                        ),
                        Text(
                          "FOR",
                          style: enFont('bold', 26, Colors.white),
                        ),
                        Text(
                          "ENGINEER",
                          style: enFont('bold', 20, Colors.white),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
          const Divider(
            color: Colors.white60,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  menuItem(1, "Home", MyIcons.icons8_home,
                      currentPage == DrawerSections.home ? true : false),
                  menuItem(2, "E-Book", MyIcons.icons8_bookmark,
                      currentPage == DrawerSections.eBook ? true : false),
                  menuItem(3, "Quiz", MyIcons.icons8_edit,
                      currentPage == DrawerSections.quiz ? true : false),
                  menuItem(4, "Score", MyIcons.icons8_document,
                      currentPage == DrawerSections.score ? true : false),
                  menuItem(5, "Research", Icons.search_rounded,
                      currentPage == DrawerSections.research ? true : false),
                  if (userType == 'admin' || userType == 'teacher')
                    menuItem(6, "Manage User", MyIcons.person_add,
                        currentPage == DrawerSections.logout ? true : false),
                ],
              ),
            ],
          ),
          Expanded(
              child: Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: menuItem(7, "Logout", MyIcons.logout,
                  currentPage == DrawerSections.logout ? true : false),
            ),
          ))
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      // color: Colors.transparent,
      color: selected ? Colors.black12 : Colors.transparent,
      child: InkWell(
        onTap: () {
          if (MediaQuery.of(context).size.width < tabletWidth) {
            Navigator.pop(context);
          }

          // Navigator.pop(context);

          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.home;
            } else if (id == 2) {
              currentPage = DrawerSections.eBook;
            } else if (id == 3) {
              currentPage = DrawerSections.quiz;
            } else if (id == 4) {
              currentPage = DrawerSections.score;
            } else if (id == 5) {
              currentPage = DrawerSections.research;
            }
          });
          if (id == 6) {
            showDialog(
              context: context,
              builder: (BuildContext context) => ManageUserDialog(
                currentUserID: userID,
                currentUserPassword: userPass,
              ),
            ).then((value) {});
          }
          if (id == 7) {
            showDialog(
              context: context,
              builder: (BuildContext context) => const LogoutDialog(),
            ).then((value) {
              setState(() {
                userID = '';
                userName = '';
                userSur = '';
                userType = '';
              });
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            children: [
              Expanded(
                // flex: 2,
                child: Icon(
                  icon,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 5,
                child: Text(title, style: enFont('bold', 18, Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
