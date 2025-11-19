import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/home_page/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

mixin SuccessfulPickupModal {
  void showSuccessfulPickupModal(
    BuildContext context, {
    required String address,
    required String date,
    required String time,
    required String wasteType,
    String? note,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * (360 / 640),
          padding: EdgeInsets.symmetric(horizontal: 19, vertical: 20),
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
                'Pickup Request\nConfirmed',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.kBlack,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              TextRegular(
                ' Thanks! Your request has been successfully\nsubmitted. Here are the details',
                color: AppColors.kPayneGray,
                fontSize: 12,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 34),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 27,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kBrightSnow,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildPickupData('Address', address),
                            SizedBox(height: 20),
                            _buildPickupData('Date & Time', '$date . $time'),
                            SizedBox(height: 20),
                            _buildPickupData('Waste Type', wasteType),
                            SizedBox(height: 20),
                            _buildPickupData(
                              'Note',
                              note ?? 'No additional note',
                            ),
                          ],
                        ),
                      ),
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildPickupData(String text, String dataText) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextRegular(
        text,
        color: AppColors.kBlueSlate,
        fontWeight: FontWeight.w500,
      ),

      Expanded(
        child: TextRegular(
          dataText,
          color: AppColors.kBlack,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.end,
        ),
      ),
    ],
  );
}
