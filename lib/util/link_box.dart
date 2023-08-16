import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:js' as js;

class LinkBox extends StatelessWidget {
  const LinkBox({Key? key}) : super(key: key);

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if(!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,right: 8.0,bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          // _launchURL("www.flaticon.com");
          js.context.callMethod('open', ['https://www.youtube.com']);
        },
        child: Container(
          color: Colors.orange[200],
          height: 80,
          child: const Center(child: Text("URL BOX"),),
        ),
      ),
    );
  }
}