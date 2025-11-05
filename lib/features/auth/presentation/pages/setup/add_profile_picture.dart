import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/auth/presentation/pages/setup/user_type_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AddProfilePicture extends StatefulWidget {
  const AddProfilePicture({super.key});

  static const String routeName = '/addProfilePicture';

  @override
  State<AddProfilePicture> createState() => _AddProfilePictureState();
}

class _AddProfilePictureState extends State<AddProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHeader(
                      'Add a profile Picture',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: AppColors.kBlack,
                    ),
                    const SizedBox(height: 8),
                    AppRichText(
                      spans: [
                        TextSpan(
                          text: 'skip this for now',
                          style: TextStyle(color: AppColors.kPrimary),
                        ),
                      ],
                      text:
                          'Your photo helps us personalize your experience and\nallows our pickup team to easily identify you. You\ncan.',
                      color: AppColors.kPayneGray,
                      fontSize: 12,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.kAntiFlashWhite,
                        ),
                        child: SvgPicture.asset(
                          AppSvgs.kUserIcon,
                          width: 40,
                          height: 40,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    Column(
                      children: [
                        OutlinedCustomButton(
                          title: 'Skip for Now',
                          isDisabledBorder: false,
                          textColor: AppColors.kPrimary,
                          onTap: () {
                            context.push(UserTypeOptions.routeName);
                          },
                        ),
                        const SizedBox(height: 16),
                        OutlinedCustomButton(
                          title: 'Upload Photo',
                          bgColor: AppColors.kPrimary,
                          textColor: AppColors.kWhite,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.kMintCream,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //  icon
                              SvgPicture.asset(
                                AppSvgs.kInformation,
                                width: 24,
                                height: 24,
                                fit: BoxFit.scaleDown,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextHeader(
                                      'Kindly note',
                                      fontSize: 14,
                                      color: AppColors.kBritishRacingGreen,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    const SizedBox(height: 8),

                                    TextRegular(
                                      'You can always update your photo later\nfrom settings.',
                                      fontSize: 12,
                                      color: AppColors.kBritishRacingGreen,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
