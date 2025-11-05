import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickupAction extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const PickupAction({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.kAntiFlashWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.kHoneydew,
            ),
            child: SvgPicture.asset(
              icon,
              width: 16,
              height: 16,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextRegular(
              title,

              fontWeight: FontWeight.w500,
              color: AppColors.kPayneGray,
            ),
          ),
        ],
      ),
    );
  }
}
