import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_back_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';

class PickupDetails extends StatefulWidget {
  const PickupDetails({super.key});

  static const String routeName = '/pickupDetails';

  @override
  State<PickupDetails> createState() => _PickupDetailsState();
}

class _PickupDetailsState extends State<PickupDetails> {
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
                'Pickup Details',
                fontWeight: FontWeight.w500,
                color: AppColors.kRaisinBlack,
              ),
              const SizedBox(height: 8),
              TextRegular(
                'Let us know where and when to pick up your\nwaste. This helps us plan accordingly.',
                fontWeight: FontWeight.w500,
                color: AppColors.kPayneGray,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
