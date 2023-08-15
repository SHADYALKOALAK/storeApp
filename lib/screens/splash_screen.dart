import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storeonline/Helbers/nav_helber.dart';
import 'package:storeonline/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with NavHelper {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),
        () => jump(context, const LoginScreen(), true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset('assets/images/img.png', fit: BoxFit.cover),
      ),
    );
  }
}
