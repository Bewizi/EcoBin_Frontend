import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCard extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const DateCard({
    super.key,
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dayName = DateFormat('EEE').format(date);

    final dayNumber = DateFormat('dd').format(date);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.kLimeGreen : AppColors.kWhite,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextRegular(
              dayName,
              color: isSelected
                  ? AppColors.kBritishRacingGreen
                  : AppColors.kLavender,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 4),
            TextRegular(
              dayNumber,
              color: isSelected
                  ? AppColors.kBritishRacingGreen
                  : AppColors.kLavender,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
