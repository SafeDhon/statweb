import 'package:flutter/material.dart';

import 'package:statweb/constants.dart';
import 'package:statweb/states/home/box_period.dart';
import 'package:statweb/states/home/box_work_live.dart';
import 'package:statweb/states/home/formular/box_formular.dart';
import 'package:statweb/states/home/vdo_grid.dart';
import 'package:statweb/states/home/vdo_list.dart';

import '../../util/login_dialog.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  @override
  Widget build(BuildContext context) {
    double widthUI = MediaQuery.of(context).size.width;
    return Column(
      children: [
        widthUI < mobileWidth ? mobile3Box() : desktop3Box(),
        // const VDOList()
        const VDOGrid()
      ],
    );
  }

  Widget desktop3Box() {
    return SizedBox(
      height: 280,
      // width:  900,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        // child: Container(color: Colors.blue,),
        child: Row(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: MyWorkLiveNav(),
              ),
            ),
            Expanded(
              child: Column(
                children: const [
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, bottom: 8),
                      child: NextPeriodNav(),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 8),
                      child: MyFormularNav(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mobile3Box() {
    return SizedBox(
      height: 400,
      // width:  900,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        // child: Container(color: Colors.blue,),
        child: Column(
          children: const [
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: MyWorkLiveNav(),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: NextPeriodNav(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: MyFormularNav(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
