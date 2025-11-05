import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/auth/presentation/pages/setup/add_profile_picture.dart';
import 'package:ecobin/features/home_page/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

mixin SuccessMessageBottomSheet {
  void showSuccessMessageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
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
                  'Success! You\'re Almost There 🎉',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kBlack,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                TextRegular(
                  'Thanks for signing up. Let\'s set up your account so\nwe can tailor your EcoBin experience to you!',
                  color: AppColors.kPayneGray,
                  // fontSize: 12,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 80),
                OutlinedCustomButton(
                  title: 'Skip for Now',
                  bgColor: AppColors.kTransparent,
                  textColor: AppColors.kPrimary,
                  isDisabledBorder: false,
                  onTap: () {
                    context.go(HomeScreen.routeName);
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  title: 'Complete Setup',
                  bgColor: AppColors.kPrimary,
                  textColor: AppColors.kWhite,
                  onTap: () {
                    context.go(AddProfilePicture.routeName);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
