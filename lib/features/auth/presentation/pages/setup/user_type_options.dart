import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/auth/presentation/pages/setup/pickup_location.dart';
import 'package:flutter/material.dart';
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
      'subTitle': 'Single user managing personal waste',
      'icon': AppSvgs.kHouse,
    },
    {
      'title': 'Business',
      'subTitle': 'For offices, stores, and commercial space',
      'icon': AppSvgs.kBuildings,
    },
    {
      'title': 'Household',
      'subTitle': 'Family or shared living space',
      'icon': AppSvgs.kHouse,
    },
  ];

  int? _selectedIndex;

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
                        });
                      },
                      context,
                      isSelected: _selectedIndex == index,
                    );
                  },
                ),
              ),

              // const SizedBox(height: 20),
              CustomButton(
                title: 'Continue',
                bgColor: _selectedIndex != null
                    ? AppColors.kPrimary
                    : AppColors.kHoneydew,
                textColor: _selectedIndex != null
                    ? AppColors.kWhite
                    : AppColors.kTealDeer,
                onTap: _selectedIndex != null
                    ? () {
                        context.push(PickupLocation.routeName);
                      }
                    : null,
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
