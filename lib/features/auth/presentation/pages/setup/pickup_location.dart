import 'package:ecobin/core/presentation/constants/images.dart';
import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_input_field.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/auth/presentation/widgets/mixins/success_to_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickupLocation extends StatefulWidget {
  const PickupLocation({super.key});

  static const String routeName = '/pickupLocation';

  @override
  State<PickupLocation> createState() => _PickupLocationState();
}

class _PickupLocationState extends State<PickupLocation>
    with SuccessToDashboardBottomSheet {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextHeader(
                'Where should we collect your\nwaste?',
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppColors.kBlack,
              ),
              const SizedBox(height: 8),
              TextRegular(
                'Enter your primary location for pickups and service-\nrelated updates.',
                fontSize: 12,
                color: AppColors.kPayneGray,
              ),
              const SizedBox(height: 0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Expanded(
                    child: AppField(
                      hintText: 'Enter your primary location',
                      prefixIcons: SvgPicture.asset(
                        AppSvgs.kGPS,
                        width: 20,
                        height: 20,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      AppImages.kMap,
                      width: 72,
                      height: 52,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              GestureDetector(
                onTap: () {},
                child: TextRegular(
                  color: AppColors.kPrimary,
                  'Use my Location',
                  fontSize: 12,
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.2),

              Flexible(
                child: OutlinedCustomButton(
                  title: 'Continue',
                  bgColor: AppColors.kHoneydew,
                  textColor: AppColors.kTealDeer,
                  onTap: () {
                    showSuccessToDashboardBottomSheet(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
