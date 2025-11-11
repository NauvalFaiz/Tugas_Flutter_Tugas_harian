import 'package:flutter/material.dart';

class CustomWidgetNews2 {
  final String title;
  final NetworkImage img;
  final String times;

  CustomWidgetNews2({
    required this.title,
    required this.img,
    required this.times,
  });
}

List<CustomWidgetNews2> news2 = [
  CustomWidgetNews2(
    title: "Nice Jazz Festival 60th Lineup",
    img: NetworkImage(''),
    times: "5 Minutes reading time",
  ),
];
