import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/home_page/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

mixin SuccessToDashboardBottomSheet {
  void showSuccessToDashboardBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.55,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.kHoneydew,
                ),
                padding: EdgeInsets.all(8),
                child: SvgPicture.asset(
                  AppSvgs.kThickCircle,
                  width: 32,
                  height: 32,
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(height: 20),
              TextHeader(
                'You’re All Set! 🌱',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.kBlack,
              ),
              const SizedBox(height: 12),
              TextRegular(
                'Thanks for setting up your profile. You’re now\nready to start managing your waste smarter with\nEcoBin.',
                color: AppColors.kPayneGray,
                fontSize: 12,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80),

              const SizedBox(height: 16),
              CustomButton(
                title: 'Go to Dashboard',
                bgColor: AppColors.kPrimary,
                textColor: AppColors.kWhite,
                onTap: () {
                  context.go(HomeScreen.routeName);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
