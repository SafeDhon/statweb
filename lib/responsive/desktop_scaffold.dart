import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:statweb/constants.dart';
import 'package:statweb/model/user_model.dart';
import 'package:statweb/states/home/home_desktop.dart';
import 'package:statweb/states/research/research_Desktop.dart';
import 'package:statweb/states/score/score_desktop.dart';
import 'package:statweb/util/header.dart';
import 'package:statweb/util/link_box.dart';
import 'package:statweb/util/my_input_box.dart';
import 'package:statweb/util/my_signin_box.dart';
import 'package:statweb/util/my_signup_box.dart';

import '../util/my_box.dart';
import '../util/my_tile.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  // final usernameController = TextEditingController();
  // final passwordController = TextEditingController();
  String user = '';
  String password = '';
  String user_withmail = '';

  String studentNo = 'Please Log in';

  @override
  void initState() {
    super.initState();
    // studentNo = getUser();
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        // Loged in
        setState(() {
          studentNo = event.displayName!;
        });
        print(studentNo);
        // await FirebaseFirestore.instance
        //     .collection('user')
        //     .doc(studentNo)
        //     .snapshots()
        //     .listen((event) {
        //   UserModel model = UserModel.fromMap(event as Map<String, dynamic>);
        //   print(model.name);
        // });
      } else {
        // Logout
        print('not login');
      }
    });
  }

  var currentPage = DrawerSections.home;
  @override
  Widget build(BuildContext context) {
// String user = '';
    var container;
    if (currentPage == DrawerSections.home) {
      container = HomeDesktop();
    } else if (currentPage == DrawerSections.eBook) {
      container = Container();
    } else if (currentPage == DrawerSections.quiz) {
      container = Container();
    } else if (currentPage == DrawerSections.score) {
      container = ScoreDesktop();
    } else if (currentPage == DrawerSections.research) {
      container = ResearchDesktop();
    }
    return Scaffold(
      backgroundColor: myDefaultBackground,
      // appBar: myAppBar,
      body: Row(
        children: [
          myDrawer(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const MyHeader(
                    user_name: 'Natthchai Safe Dhon',
                  ),
                  Expanded(
                    child: container,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget myDrawer() {
    return Drawer(
      backgroundColor: metallicBlue,
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(top: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/icons/idea.png',
                      width: 50,
                    ),
                    Column(
                      children: [
                        Text(
                          "STAT",
                          style: enFont('bold', 10, Colors.white),
                        ),
                        Text(
                          "ทดสอบฟอนด์ไทย เทสเทส",
                          style: thFont('bold', 15, Colors.black),
                        ),
                        Text(
                          "ENGINEER",
                          style: enFont('bold', 20, Colors.green),
                        ),
                      ],
                    ),
                  ]),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  menuItem(1, "Home", Icons.abc_outlined,
                      currentPage == DrawerSections.home ? true : false),
                  menuItem(2, "E-Book", Icons.abc_outlined,
                      currentPage == DrawerSections.eBook ? true : false),
                  menuItem(3, "Quiz", Icons.abc_outlined,
                      currentPage == DrawerSections.quiz ? true : false),
                  menuItem(4, "Score", Icons.abc_outlined,
                      currentPage == DrawerSections.score ? true : false),
                  menuItem(5, "Research", Icons.abc_outlined,
                      currentPage == DrawerSections.research ? true : false),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      // color: Colors.transparent,
      color: selected ? Colors.white10 : Colors.transparent,
      child: InkWell(
        onTap: () {
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
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future createUser() async {
    if ((user.isEmpty == true) || (password.isEmpty == true)) {
      print('***** fillin *****');
    } else {
      print(user);
      print(password);
      user_withmail = user + '@gmail.com';
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user_withmail, password: password)
          .then((value) async {
        await value.user?.updateDisplayName(user).then((value) async {
          UserModel model =
              UserModel(name: 'safe', surname: 'sa', typeuser: 'tt', year: '5');
          Map<String, dynamic> data = model.toMap();

          await FirebaseFirestore.instance
              .collection('user')
              .doc(user)
              .set(data)
              .then((value) {
            print('add success');
            setState(() {
              studentNo = user;
            });
          });
        });
      }).catchError((onError) => print(onError));
    }
  }

  Future signin() async {
    if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
      print('***** fillin *****');
    } else {
      print(user);
      print(password);
      user_withmail = user + '@gmail.com';
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user_withmail, password: password)
          .then((value) => print(value));
    }
  }

  logout() async {
    print('Log Out');
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.signOut().then((value) => null);
    });
    setState(() {
      studentNo = 'Please Log in';
    });
  }
}

enum DrawerSections {
  home,
  eBook,
  quiz,
  score,
  research,
}



// Future<String> getUser() async {
//   String? studentNo = '';
//   await FirebaseAuth.instance.authStateChanges().listen((event) async {
//     if (event != null) {
//       // Loged in
//       studentNo = event.displayName;
//       print(studentNo);
//       // await FirebaseFirestore.instance
//       //     .collection('user')
//       //     .doc(studentNo)
//       //     .snapshots()
//       //     .listen((event) {
//       //   UserModel model = UserModel.fromMap(event as Map<String, dynamic>);
//       //   print(model.name);
//       // });
//       return studentNo;
//     } else {
//       // Logout
//       return '';
//     }
//   });
// }
