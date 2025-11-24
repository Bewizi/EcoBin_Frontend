import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/auth/presentation/pages/setup/pickup_location.dart';
import 'package:ecobin/features/profile/domain/profile.dart';
import 'package:ecobin/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class UserTypeOptions extends StatefulWidget {
  const UserTypeOptions({super.key});

  static const String routeName = '/userTypeOptions';

  @override
  State<UserTypeOptions> createState() => _UserTypeOptionsState();
}

class _UserTypeOptionsState extends State<UserTypeOptions> {
  final List<Map<String, dynamic>> _options = [
    {
      'title': 'Individual',
      'value': 'individual',
      'subTitle': 'Single user managing personal waste',

      'icon': AppSvgs.kHouse,
    },
    {
      'title': 'Business',
      'value': 'business',
      'subTitle': 'For offices, stores, and commercial space',
      'icon': AppSvgs.kBuildings,
    },
    {
      'title': 'Household',
      'value': 'household',
      'subTitle': 'Family or shared living space',
      'icon': AppSvgs.kHouse,
    },
  ];

  int? _selectedIndex;
  late String _selectedUserType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextHeader(
                'Who’s using EcoBin?',
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppColors.kBlack,
              ),
              const SizedBox(height: 8),
              TextRegular(
                'Choose your user type so we can customize the\nwaste services and notifications for you.',
                // fontSize: 12,
                color: AppColors.kPayneGray,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView.builder(
                  itemCount: _options.length,
                  itemBuilder: (context, index) {
                    final option = _options[index];

                    return _buildUserOptions(
                      option['title'],
                      option['subTitle'],
                      option['icon'],
                      () {
                        setState(() {
                          _selectedIndex = index;
                          _selectedUserType = option['value'];
                        });
                      },
                      context,
                      isSelected: _selectedIndex == index,
                    );
                  },
                ),
              ),

              // const SizedBox(height: 20),
              BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: TextRegular(
                          'User type saved successfully!',
                          color: AppColors.kWhite,
                        ),
                        backgroundColor: AppColors.kPrimary,
                      ),
                    );
                    context.go(PickupLocation.routeName);
                  } else if (state is ProfileError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: TextRegular(
                          state.message,
                          color: AppColors.kWhite,
                        ),
                        backgroundColor: AppColors.kError500,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is ProfileLoading;
                  return CustomButton(
                    title: isLoading ? 'Saving...' : 'Continue',
                    bgColor: _selectedIndex != null
                        ? AppColors.kPrimary
                        : AppColors.kHoneydew,
                    textColor: _selectedIndex != null
                        ? AppColors.kWhite
                        : AppColors.kTealDeer,
                    onTap: (_selectedIndex != null && !isLoading)
                        ? () {
                            // ✅ Dispatch event to save to backend
                            context.read<ProfileBloc>().add(
                              CreateProfileEvent(
                                Profile(
                                  fullName: null,
                                  avatar: null,
                                  pickupLocation: null,
                                  userType: _selectedUserType,
                                ),
                              ),
                            );
                          }
                        : null,
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildUserOptions(
  String title,
  String subtitle,
  String icon,
  VoidCallback? ontap,
  BuildContext context, {
  bool isSelected = false,
}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(
        left: 20,
        right: MediaQuery.of(context).padding.right * 0.1,
        top: 16,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.kPayneGray : AppColors.kAntiFlashWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 20,
                height: 20,
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                  isSelected ? AppColors.kWhite : AppColors.kBlack,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 12),
              TextHeader(
                title,
                fontSize: 16,
                color: isSelected ? AppColors.kWhite : AppColors.kBlack,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextRegular(
            subtitle,
            color: isSelected ? AppColors.kWhite : AppColors.kPayneGray,
            fontSize: 12,
          ),
        ],
      ),
    ),
  );
}
