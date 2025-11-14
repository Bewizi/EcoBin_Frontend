import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_back_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';

class HouseholdDetails extends StatefulWidget {
  const HouseholdDetails({super.key});
  static const String routeName = '/householdDetails';

  // final bool isChecked = false;

  @override
  State<HouseholdDetails> createState() => _HouseholdDetailsState();
}

class _HouseholdDetailsState extends State<HouseholdDetails> {
  final List<String> reasons = [
    'Driver didn’t move',
    'Driver went to the wrong location',
    'Long pick up time',
    'Driver asked me to cancel',
    'Accidental request',
    'Other',
  ];
  List<bool> chekedList = [];

  @override
  void initState() {
    super.initState();

    chekedList = List.generate(reasons.length, (_) => false);
  }

  void _handleCheckboxChange(int index, bool? value) {
    if (value == true) {
      setState(() {
        for (int i = 0; i < chekedList.length; i++) {
          chekedList[i] = false;
        }

        chekedList[index] = true;
      });
    } else {
      setState(() {
        chekedList[index] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: AppBackButton()),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextHeader(
                'Household Waste Details',
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

                        value: chekedList[index],
                        onChanged: (bool? value) {
                          _handleCheckboxChange(index, value);
                        },
                      ),
                    ),
                    // text
                    TextRegular(
                      reason,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.kBlack,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
