import 'package:flutter/material.dart';
import 'package:statweb/constants.dart';
import 'package:statweb/util/my_box.dart';
import 'package:statweb/util/my_tile.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {

    var currentPage = DrawerSections.home;
    return Scaffold(
      appBar:  myAppBar('currentHeader', []),
      backgroundColor: myDefaultBackground,
      // drawer: myDrawer(currentPage,(){}),
      body: Column(
        children: [

          // 4 box on top
          AspectRatio(
            aspectRatio: 1,
            child: SizedBox(
              width: double.infinity,
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return const MyBox();
                }        
              ),
            ),
          ),

          // tile below
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const MyTile();
              },
            ),
          ),
        ]
      ),
    );
  }
}