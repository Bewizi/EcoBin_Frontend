import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_back_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/requests/presentation/pages/pickup_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ElectronicWasteDetails extends StatefulWidget {
  const ElectronicWasteDetails({super.key});
  static const String routeName = '/electronicWasteDetails';

  @override
  State<ElectronicWasteDetails> createState() => _ElectronicWasteDetailsState();
}

class _ElectronicWasteDetailsState extends State<ElectronicWasteDetails> {
  final List<Map<String, String>> reasons = [
    {'icon': AppSvgs.kShopeefoodDriver, 'text': 'Batteries'},
    {'icon': AppSvgs.kTissuePaper, 'text': 'SmartPhones and Tablets'},
    {'icon': AppSvgs.kDamageMap, 'text': 'Chargers and Cables'},
    {'icon': AppSvgs.kClothesOutline, 'text': 'Laptops and Computers'},
    {'icon': AppSvgs.kLucideHouse, 'text': 'All kind of electronic waste'},
  ];

  List<bool> chekedList = [];

  bool get isAnyChecked => chekedList.any((isChecked) => isChecked);

  @override
  void initState() {
    super.initState();

    chekedList = List.generate(reasons.length, (_) => false);
  }

  void _handleCheckboxChange(int index, bool? value) {
    setState(() {
      chekedList[index] = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool buttonActive = isAnyChecked;
    return Scaffold(
      appBar: AppBar(leading: AppBackButton()),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextHeader(
                'Electronic Waste Details',
                fontWeight: FontWeight.w500,
                color: AppColors.kRaisinBlack,
              ),
              const SizedBox(height: 8),
              TextRegular(
                'Help us understand what you\'re disposing of\nso we can come prepared with the right tools\nand team',
                fontWeight: FontWeight.w500,
                color: AppColors.kPayneGray,
              ),
              SizedBox(height: 40),

              ...List.generate(reasons.length, (index) {
                final reason = reasons[index];
                return Row(
                  children: [
                    CheckboxTheme(
                      data: CheckboxThemeData(shape: CircleBorder()),
                      child: Checkbox(
                        checkColor: AppColors.kPrimary,
                        side: BorderSide(color: AppColors.kSlateGray, width: 1),
                        value: chekedList[index],
                        onChanged: (bool? value) {
                          _handleCheckboxChange(index, value);
                        },
                      ),
                    ),

                    // icon
                    SvgPicture.asset(
                      reason['icon'] as String,
                      width: 20,
                      height: 20,
                      fit: BoxFit.scaleDown,
                    ),

                    SizedBox(width: 8),

                    // text
                    TextRegular(
                      reason['text'] as String,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.kBlack,
                    ),
                  ],
                );
              }),

              Spacer(),

              Expanded(
                child: Column(
                  children: [
                    CustomButton(
                      title: 'Next',
                      bgColor: buttonActive
                          ? AppColors.kPrimary
                          : AppColors.kHoneydew,
                      textColor: buttonActive
                          ? AppColors.kWhite
                          : AppColors.kTealDeer,
                      onTap: (buttonActive)
                          ? () {
                              context.push(PickupDetails.routeName);
                            }
                          : null,
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
