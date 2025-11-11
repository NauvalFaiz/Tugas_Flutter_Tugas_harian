import 'package:belajar_flutter_r7/Widgets/Pages/Navbar/root.dart';
import 'package:flutter/material.dart';

class SplaceScreen extends StatefulWidget {
  SplaceScreen({super.key});

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controler;
  late Animation<double> _opacity;
  late Animation<double> _scale;
  @override
  void initState() {
    super.initState();
    _controler = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controler, curve: Curves.easeIn));
    _scale = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(CurvedAnimation(parent: _controler, curve: Curves.elasticOut));
    _controler.forward();
    Future.delayed(Duration(seconds: 10), () {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Root()),
          (r) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: Colors.lightBlueAccent.withOpacity(0.3),
      body: Center(
        child: FadeTransition(
          opacity: _opacity,
          child: ScaleTransition(
            scale: _scale,
            child: Center(
              child: Image.asset(
                "assets/images/logoSekolah.png",
                height: 100,
                width: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
