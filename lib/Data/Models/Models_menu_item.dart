// models/menu_item.dart
import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String iconPath;
  final Widget page;

  MenuItem({
    required this.title,
    required this.iconPath,
    required this.page,
  });
}