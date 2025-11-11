import 'package:flutter/material.dart';

class CustomWidgetNews {
  final NetworkImage img;
  final String title;
  final Stringa; 
  final Stringb; 
  CustomWidgetNews(this.title,  this.Stringa, this.Stringb, {required this.img,});
}

List<CustomWidgetNews> news = [
  CustomWidgetNews(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit",

    img: NetworkImage(
      'https://i.pinimg.com/736x/ca/ab/44/caab441b91e153195e3c24155d7fefe2.jpg',
    ),
    "10 Minutes",
    "100"
  ),
  CustomWidgetNews(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    img: NetworkImage(
      'https://i.pinimg.com/736x/ca/ab/44/caab441b91e153195e3c24155d7fefe2.jpg',
    ),
  "12 Minutes",
  "300"
  ),
  CustomWidgetNews(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    img: NetworkImage(
      'https://i.pinimg.com/736x/ca/ab/44/caab441b91e153195e3c24155d7fefe2.jpg',
    ),
  "30 Minutes",
  "50"
  ),
  CustomWidgetNews(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    img: NetworkImage(
      'https://i.pinimg.com/736x/ca/ab/44/caab441b91e153195e3c24155d7fefe2.jpg',
    ),
   "2 Minutes",
   "52"
  ),
];
