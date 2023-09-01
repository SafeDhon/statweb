import 'package:flutter/material.dart';
import 'package:statweb/constants.dart';

import '../states/home/home_desktop.dart';
import '../states/research/research_Desktop.dart';
import '../states/score/score_desktop.dart';
import '../util/my_box.dart';
import '../util/my_tile.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  var currentPage = DrawerSections.home;

  @override
  Widget build(BuildContext context) {
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
     
    bool test = true;

    return Scaffold(
        backgroundColor: myDefaultBackground,
        appBar: test ? myAppBar('currentHeader', []) : null,
        drawer: myDrawer(),
        body: container);
  }

  Widget myDrawer() {
    return Drawer(
      backgroundColor: metallicBlue,
      child: SingleChildScrollView(
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
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      // color: Colors.transparent,
      color: selected ? Colors.white10 : Colors.transparent,
      child: InkWell(
        onTap: () {
          
          Navigator.pop(context);
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

}

enum DrawerSections {
  home,
  eBook,
  quiz,
  score,
  research,
}
