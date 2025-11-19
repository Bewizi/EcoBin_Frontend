import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class SchedulePickupInfo extends StatelessWidget {
  final String date;
  final String time;
  
  const SchedulePickupInfo({
    super.key,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.kMintCream,
      ),
      child: Row(
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
            child: TextRegular(
              'Your next pickup is scheduled for $date, $time',
              fontSize: 12,
              color: AppColors.kBritishRacingGreen,
            ),
          ),
        ],
      ),
    );
  }
}
