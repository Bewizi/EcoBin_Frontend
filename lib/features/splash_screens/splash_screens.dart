import 'package:ecobin/core/presentation/constants/images.dart';
import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/auth/presentation/pages/signUp/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  static const String routeName = '/splashScreens';

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> splashData = [
    {
      'imagePath': AppSvgs.kPana1,
      'title': 'Smart Waste\nManagement at\nYour Fingertips',
      'description':
          'Schedule pickups, track collections,\nand keep your environment clean\neffortlessly',
      'bgColor': AppColors.kAntiFlashWhite,
      'textColor': AppColors.kBlack,
    },
    {
      'imagePath': AppSvgs.kCuate1,
      'title': 'Pickups Made Simple',
      'description':
          'Select pickup times, track your\nwaste status, and enjoy a cleaner\nspace — all in a few taps.',
      'bgColor': AppColors.kCinerous,
    },
    {
      'imagePath': AppSvgs.kBro1,
      'title': 'Join the Green Movement',
      'description':
          'Recycling right and proper disposal\nhelp build a healthier planet for\neveryone',
      'bgColor': AppColors.kPrimary,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Image.asset(AppImages.kLogo, width: 40.w)],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //page view
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) => setState(() {
                    currentIndex = value;
                  }),
                  itemCount: splashData.length,
                  itemBuilder: (context, index) {
                    final data = splashData[index];
                    return _builderItem(
                      context,
                      data['imagePath'],
                      data['title'],
                      data['description'],
                      data['bgColor'],
                      data['textColor'] ?? AppColors.kWhite,
                      currentIndex,
                      splashData.length,
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),

              CustomButton(
                title: 'Get Started',
                bgColor: AppColors.kPrimary,
                onTap: () {
                  context.go(SignUp.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _builderItem(
  BuildContext context,
  String imagePath,
  String title,
  String description,
  Color bgColor,
  Color textColor,
  int currentIndex,
  int total,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHeader(
                        title,
                        fontSize: 32,
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 14),
                      TextRegular(
                        description,
                        color: textColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      const SizedBox(height: 20),
                      // indcator
                      Row(
                        children: List.generate(total, (index) {
                          final isActive = index == currentIndex;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 8),
                            width: isActive ? 40 : 20,
                            height: 10,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.kLavender
                                  : AppColors.kLavender.withValues(alpha: 0.50),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.2),

                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    imagePath,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
