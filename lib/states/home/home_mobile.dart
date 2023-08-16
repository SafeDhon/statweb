import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class HonmeMobile extends StatefulWidget {
  const HonmeMobile({super.key});

  @override
  State<HonmeMobile> createState() => _HonmeMobileState();
}

class _HonmeMobileState extends State<HonmeMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Mobile'),
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