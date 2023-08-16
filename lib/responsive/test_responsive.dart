import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TestResponsive extends StatefulWidget {
  const TestResponsive({super.key});

  @override
  State<TestResponsive> createState() => _TestResponsiveState();
}

class _TestResponsiveState extends State<TestResponsive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width < 1100 ? AppBar() : null,
      body: Row(
        children: [
          MediaQuery.of(context).size.width < 1100
              ? Container()
              : Container(
                width: 300,
                color: Colors.green,
              ),
          Expanded(
            flex: 3,
            child: Container(
              color: MediaQuery.of(context).size.width < 500
                  ? Colors.pink
                  : Colors.orange,
              child: Center(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: TextField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search...',
                      ),
                      onChanged: (val) {
                        setState(() {
                          // search = val;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
