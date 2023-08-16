import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:statweb/constants.dart';
import 'package:statweb/states/eBook/eBookDesktop.dart';
import 'package:statweb/states/formular/formular_list.dart';
import 'package:statweb/states/home/vdo_list.dart';
import 'package:statweb/states/quiz/quiz_units.dart';
import 'package:statweb/states/research/research_Desktop.dart';
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

  var currentPage = DrawerSections.home;
  String currentHeader = 'Home';
  String userID = '';
  String userName = '';
  String userSur = '';
  String userType = '';

  @override
  void initState() {
    super.initState();
    getformPrefer();
  }

  Future<void> getformPrefer() async {
    print('...................... Get Preferences ......................');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userID = preferences.getString('id')!;
      userName = preferences.getString('name')!;
      userSur = preferences.getString('surname')!;
      userType = preferences.getString('type')!;
    });
    print(preferences.getString('id'));
    print(preferences.getString('name'));
    print(preferences.getString('surname'));
    print(preferences.getString('type'));
  }

  Future<void> getData(String user) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user)
        .get()
        .then((value) {
      // userName = value['name'];
      // userSur = value['surname'];
      // userType = value['typeuser'];
      setState(() {
        userName = value['name'];
        userSur = value['surname'];
        userType = value['typeuser'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic contain;
    if (currentPage == DrawerSections.home) {
      contain = HomeDesktop();
      currentHeader = 'Home';
    } else if (currentPage == DrawerSections.eBook) {
      contain = EBookDeskTop();
      currentHeader = 'E-Book';
    } else if (currentPage == DrawerSections.quiz) {
      contain = QuizUnit();
      currentHeader = 'Quiz';
    } else if (currentPage == DrawerSections.score) {
      // contain = ScoreDesktop();
      contain = ScoreDesktop();
      currentHeader = 'Score';
    } else if (currentPage == DrawerSections.research) {
      contain = ResearchDesktop();
      currentHeader = 'Research';
    }

    return Scaffold(
      appBar: MediaQuery.of(context).size.width < tabletWidth ? myAppBar : null,
      drawer: myDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MediaQuery.of(context).size.width < tabletWidth
              ? Container()
              : myDrawer(),
          Expanded(child: Container()),
          SizedBox(
            width: MediaQuery.of(context).size.width < mobileWidth ? 500 : 1100,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentHeader,
                              style: enFont('semibold', 50, metallicBlue),
                            ),
                            // widget.user == ''
                            userID == ''
                                ? LoginTopButton(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            const LoginDialog(),
                                      ).then((value) async {
                                        await getformPrefer();
                                        // getData(widget.user).then((value) {
                                        //   print('get Data 555555555555555555555');
                                        //   // if (userName.isNotEmpty) {
                                        //   //   isLoading = false;
                                        //   // } else {
                                        //   //   isLoading = true;
                                        //   // }
                                        // });
                                      });
                                    },
                                  )
                                : MyHeader(
                                    user_name: '$userID  $userName $userSur',
                                  ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: contain),
                      ],
                    ),
                  ),
                  chatButton(),
                ],
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget chatButton() {
    return Positioned(
      bottom: 10,
      right: 10,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: metallicBlue,
        child: const Center(
          child: Icon(
            Icons.message_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget myDrawer() {
    return Drawer(
      width: 250,
      backgroundColor: glaucous,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsetsDirectional.only(top: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/icons/idea.png',
                    width: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "STAT",
                        style: enFont('bold', 25, Colors.white),
                      ),
                      Text(
                        "FOR",
                        style: enFont('bold', 25, Colors.white),
                      ),
                      Text(
                        "ENGINEER",
                        style: enFont('bold', 25, Colors.white),
                      ),
                    ],
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
                  menuItem(1, "Home", Icons.home_rounded,
                      currentPage == DrawerSections.home ? true : false),
                  menuItem(2, "E-Book", Icons.menu_book_rounded,
                      currentPage == DrawerSections.eBook ? true : false),
                  menuItem(3, "Quiz", Icons.edit_rounded,
                      currentPage == DrawerSections.quiz ? true : false),
                  menuItem(4, "Score", Icons.library_books_rounded,
                      currentPage == DrawerSections.score ? true : false),
                  menuItem(5, "Research", Icons.manage_search_rounded,
                      currentPage == DrawerSections.research ? true : false)
                ],
              ),
            ],
          ),
          Expanded(
              child: Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: menuItem(6, "Logout", Icons.logout_rounded,
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
          if (MediaQuery.of(context).size.width < 1100) {
            Navigator.pop(context);
          }
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
