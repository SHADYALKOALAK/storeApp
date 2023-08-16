import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeonline/Helbers/nav_helber.dart';
import 'package:storeonline/enums.dart';
import 'package:storeonline/firebase/users_fb_controller.dart';
import 'package:storeonline/providers/auth_provider.dart';
import 'package:storeonline/providers/cache/cache_controller.dart';
import 'package:storeonline/screens/bnb/home_page_screen.dart';
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
    init;
  }

  Future<void> get init async {
    bool loggedIn = CacheController().getter(CacheKeys.loggedIn) ?? false;
    if (loggedIn) {
      var user = await UsersFbController()
          .show(CacheController().getter(CacheKeys.email));

      if (context.mounted) {
        Provider.of<AuthProvider>(context, listen: false).user = user;
      }
    }
    Future.delayed(
      const Duration(seconds: 3),
      () => jump(
        context,
        loggedIn ? const HomePageScreen() : const LoginScreen(),
        true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset('assets/images/splash_image.png', fit: BoxFit.cover),
      ),
    );
  }
}
