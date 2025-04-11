import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/src/app/app_theme.dart';
import 'package:grocery_app/src/app/route_config.dart';
import 'package:grocery_app/src/app/utils/assets_path.dart';
import 'package:grocery_app/src/service/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(child: SvgPicture.asset(AssetPath.logo)),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ],
      ),
    );
  }

  void checkLogin() async {
    bool isLoggedIn = await SharedPrefService.getLoginStatus();
    Future.delayed(const Duration(seconds: 4), () {
      context.pushReplacement(isLoggedIn ? AppRoute.home : AppRoute.startPage);
    });
  }
}
