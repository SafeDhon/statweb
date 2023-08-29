import 'package:flutter/material.dart';

import 'package:statweb/states/home/box_period.dart';
import 'package:statweb/states/home/formular/box_formular.dart';

import 'package:statweb/states/home/box_work_live.dart';
import 'package:statweb/states/home/vdo_list.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({super.key});

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
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
        ),
        // SizedBox(
        //   height: 200,
        //   child: ListView.builder(
        //     // scrollDirection: Axis.horizontal,
        //     itemCount: 10,
        //     itemBuilder: (context, index) {
        //     return Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Container(
        //         width: 100,
        //         height: 100,
        //         color: Colors.green,
        //       ),
        //     );
        //   }),
        // )
    
        const VDOList()
    
      ],
    );

    // return SingleChildScrollView(
    //   child: Column(children: [
    //     Expanded(
    //       flex: 1,
    //       child: Container(
    //         color: beauBlue,
    //       ),
    //     ),
    //     Expanded(
    //       flex: 8,
    //       child: Container(
    //         color: paleYellow,
    //       ),
    //     ),
    //   ]),
    // );
  }
}
