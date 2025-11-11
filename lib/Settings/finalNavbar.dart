import 'package:flutter/material.dart';

class Nav extends StatelessWidget {
  const Nav({super.key, required this.currentIndex, required this.tap});
  final int currentIndex;
  final ValueChanged<int> tap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: tap,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        
      ],
    );
  }
}
