import 'package:ecobin/core/presentation/constants/images.dart';
import 'package:ecobin/features/splash_screens/splash_screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreenLogo extends StatefulWidget {
  const SplashScreenLogo({super.key});

  static const String routeName = '/splashScreenLogo';

  @override
  State<SplashScreenLogo> createState() => _SplashScreenLogoState();
}

class _SplashScreenLogoState extends State<SplashScreenLogo> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        context.go(SplashScreens.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.kLogo,
          width: MediaQuery.of(context).size.width * 0.40,
        ),
      ),
    );
  }
}
