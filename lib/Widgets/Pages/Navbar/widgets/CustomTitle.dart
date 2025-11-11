import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Customtitle {
  final IconData icon;
  final String title;
  Color? color;

  Customtitle({this.color, required this.icon, required this.title});
}

List<Customtitle> customtitle = [
  Customtitle(icon: Icons.insights, title: "Actifity"),
  Customtitle(icon: Icons.location_on_outlined, title: 'Location'),
  Customtitle(icon: CupertinoIcons.bell, title: "Notification"),
  Customtitle(
    icon: CupertinoIcons.arrow_right_arrow_left,
    title: "Logout",
    color: Colors.blue,
  ),
];
