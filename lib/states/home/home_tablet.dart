import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class HomeTablet extends StatefulWidget {
  const HomeTablet({super.key});

  @override
  State<HomeTablet> createState() => _HomeTabletState();
}

class _HomeTabletState extends State<HomeTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Desktop'),
            TextButton(
              onPressed: () {
                Beamer.of(context).beamToNamed('/score');
              },
              child: const Text("Score"),
            )
          ],
        ),
      ),
    );
  }
}