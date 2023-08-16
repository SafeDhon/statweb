import 'package:flutter/material.dart';
import 'package:statweb/responsive/reponsive_layout.dart';
import 'package:statweb/states/home/home_desktop.dart';
import 'package:statweb/states/home/home_mobile.dart';
import 'package:statweb/states/home/home_tablet.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveLayout(
//       mobileScaffold: const HonmeMobile(),
//       tabletScaffold: const HomeTablet(),
//       desktopScaffold: const HomeDesktop(),
//     );
//   }
// }

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: const HonmeMobile(),
      tabletScaffold: const HomeTablet(),
      desktopScaffold: const HomeDesktop(),
    );
  }
}
