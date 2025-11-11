import 'package:belajar_flutter_r7/Data/Views/SiswaView.dart';
import 'package:belajar_flutter_r7/Widgets/Pages/Navbar/Profil_user.dart';
import 'package:flutter/material.dart';
// lib/root.dart
// import 'package:belajar_flutter_r7/Widgets/Pages/ProfilUser.dart'; // Pastikan file ini ada!
// import 'package:belajar_flutter_r7/Data/Views/SiswaView.dart';
import 'package:belajar_flutter_r7/Widgets/Pages/HotNews.dart';
import 'package:belajar_flutter_r7/Widgets/Pages/HomePage.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentIndex = 0;

  final List<Widget> _navbar = [HomePage(), SiswaView(), Hotnews(), User()];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navbar[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Siswa'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
