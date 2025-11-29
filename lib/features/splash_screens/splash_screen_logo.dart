import 'package:ecobin/core/presentation/constants/images.dart';
import 'package:ecobin/features/auth/presentation/pages/signIn/sign_in.dart';
import 'package:ecobin/features/auth/presentation/state/bloc/login_bloc.dart';
import 'package:ecobin/features/home_page/presentation/pages/home_screen.dart';
import 'package:ecobin/features/splash_screens/splash_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    context.read<AuthBloc>().add(CheckAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthSate>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Navigate to home screen or dashboard
          context.go(HomeScreen.routeName);
        } else if (state is AuthInitial || state is AuthFailure) {
          // Navigate to login screen
          context.go(SignIn.routeName);
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            AppImages.kLogo,
            width: MediaQuery.of(context).size.width * 0.40,
          ),
        ),
      ),
    );
  }
}
