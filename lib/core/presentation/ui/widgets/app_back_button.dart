import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SvgPicture.asset(
        AppSvgs.kArrowLeft,
        width: 24,
        height: 24,
        fit: BoxFit.scaleDown,
      ),
      onTap: () => context.pop(),
    );
  }
}
