import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class Profilecompany {
  final String title;
  final String buttonText;
  final IconData icon;

  Profilecompany({
    required this.title,
    required this.buttonText,
    required this.icon,
  });
}

List<Profilecompany> profilecompany = [
  Profilecompany(
    title: "Set Your Profile Details",
    buttonText: "Continue",
    icon: CupertinoIcons.person_circle,
  ),
  Profilecompany(
    title: "Set Your resume",
    buttonText: "Upload",
    icon: CupertinoIcons.doc,
  ),
  Profilecompany(
    title: "Add your skills",
    buttonText: "Add",
    icon: CupertinoIcons.square_list,
  ),
];
