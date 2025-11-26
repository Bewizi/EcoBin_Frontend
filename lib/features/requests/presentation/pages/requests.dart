import 'package:ecobin/core/presentation/constants/images.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/navigation/page_navigation_bar.dart';
import 'package:ecobin/features/requests/presentation/pages/electronic_waste%20_details.dart';
import 'package:ecobin/features/requests/presentation/pages/household_details.dart';
import 'package:ecobin/features/requests/presentation/pages/medical_waste%20_details.dart';
import 'package:ecobin/features/requests/presentation/pages/organic_waste%20_details.dart';
import 'package:ecobin/features/requests/presentation/pages/recyclables_details.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Requests extends StatelessWidget {
  const Requests({super.key});

  static const String routeName = '/requests';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PageNavigationBar(currentIndex: 2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextHeader(
                'What type of waste would\nyou like us to pick up?',
                fontWeight: FontWeight.w500,
                color: AppColors.kRaisinBlack,
              ),
              const SizedBox(height: 8),
              TextRegular(
                'Choose the waste category below. This helps\nus prepare the right team and equipment.',
                fontWeight: FontWeight.w500,
                color: AppColors.kPayneGray,
              ),

              const SizedBox(height: 20),

              // list builder
              SizedBox(
                height: MediaQuery.of(context).size.height * (360 / 640),
                child: ListView(
                  children: [
                    InkWell(
                      // navigate to the household details page with a string id (slug or uuid)
                      onTap: () => context.push(
                        '${HouseholdDetails.routeName}/household',
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.kAntiFlashWhite,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _buildPickUpType(
                          context,
                          'Household Waste',
                          'Everyday non-recyclable items like\nfood wrappers, tissues, etc',
                          AppImages.kHouseholdWaste,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    InkWell(
                      onTap: () => context.push(
                        ' ${RecyclablesDetails.routeName}/recyclables',
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.kAntiFlashWhite,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _buildPickUpType(
                          context,
                          'Recyclables',
                          'Plastic bottles, cans, glass, paper,\nand other recyclable items.',
                          AppImages.kRecyclables,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Organic Waste
                    InkWell(
                      onTap: () => context.push(
                        '${OrganicWasteDetails.routeName}/organicwaste',
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.kAntiFlashWhite,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _buildPickUpType(
                          context,
                          'Organic Waste',
                          'Food scraps, garden waste —\ngreat for composting!',
                          AppImages.kOrganicWaste,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Electronic Waste
                    InkWell(
                      onTap: () => context.push(
                        '${ElectronicWasteDetails.routeName}/electronicwaste',
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.kAntiFlashWhite,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _buildPickUpType(
                          context,
                          'Electronic Waste',
                          'Food scraps, garden waste —\ngreat for composting!',
                          AppImages.kElectronicWaste,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Medical Waste
                    InkWell(
                      onTap: () => context.push(
                        '${MedicalWasteDetails.routeName}/medicalwaste',
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.kAntiFlashWhite,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _buildPickUpType(
                          context,
                          'Medical Waste',
                          'Used masks, gloves, syringes.\nMust be safely handled.',
                          AppImages.kMedicalWaste,
                        ),
                      ),
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

Widget _buildPickUpType(
  BuildContext context,
  String textHeader,
  String textRegular,
  String image,
) {
  return Stack(
    children: [
      Row(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(top: 20, bottom: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextHeader(
                  textHeader,
                  fontSize: 20,
                  color: AppColors.kRaisinBlack,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 8),
                TextRegular(textRegular, color: AppColors.kPayneGray),
              ],
            ),
          ),
        ],
      ),
      // either i use spacer or expandable or flexible
      // image
      Positioned(
        bottom: -45,
        right: 0,
        child: Image.asset(
          image,
          width: MediaQuery.of(context).size.width * (180 / 640),
        ),
      ),
    ],
  );
}
