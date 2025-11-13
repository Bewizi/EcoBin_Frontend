import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/features/activities/activities.dart';
import 'package:ecobin/features/home_page/presentation/pages/home_screen.dart';
import 'package:ecobin/features/profile/presentation/pages/profile.dart';
import 'package:ecobin/features/requests/requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class PageNavigationBar extends StatelessWidget {
  final int currentIndex;

  const PageNavigationBar({super.key, required this.currentIndex});

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(HomeScreen.routeName);
        break;
      case 1:
        context.go(Activities.routeName);
        break;
      case 2:
        context.go(Requests.routeName);
        break;
      case 3:
        context.go(Profile.routeName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (index) => _onDestinationSelected(context, index),
      indicatorColor: AppColors.kTransparent,
      selectedIndex: currentIndex,
      backgroundColor: AppColors.kWhite,
      destinations: [
        NavigationDestination(
          selectedIcon: SvgPicture.asset(
            AppSvgs.kHomeRounded,
            colorFilter: ColorFilter.mode(AppColors.kPrimary, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(
            AppSvgs.kHomeRounded,
            colorFilter: ColorFilter.mode(
              AppColors.kPayneGray,
              BlendMode.srcIn,
            ),
          ),
          label: 'Home',
        ),

        // Activity
        NavigationDestination(
          selectedIcon: SvgPicture.asset(
            AppSvgs.kActivity,
            colorFilter: ColorFilter.mode(AppColors.kPrimary, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(
            AppSvgs.kActivity,
            colorFilter: ColorFilter.mode(
              AppColors.kPayneGray,
              BlendMode.srcIn,
            ),
          ),
          label: 'Activity',
        ),

        // Requests
        NavigationDestination(
          selectedIcon: SvgPicture.asset(
            AppSvgs.kRequestsBin,
            colorFilter: ColorFilter.mode(AppColors.kPrimary, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(
            AppSvgs.kRequestsBin,
            colorFilter: ColorFilter.mode(
              AppColors.kPayneGray,
              BlendMode.srcIn,
            ),
          ),
          label: 'Requests',
        ),

        //Profile
        NavigationDestination(
          selectedIcon: SvgPicture.asset(
            AppSvgs.kProfile,
            colorFilter: ColorFilter.mode(AppColors.kPrimary, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(
            AppSvgs.kProfile,
            colorFilter: ColorFilter.mode(
              AppColors.kPayneGray,
              BlendMode.srcIn,
            ),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
