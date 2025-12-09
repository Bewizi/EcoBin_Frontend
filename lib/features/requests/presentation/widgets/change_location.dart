import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLocation extends StatelessWidget {
  final TextEditingController addressController;
  final Future<void> Function() onGetCurrentLocation;
  final void Function(String) onUseSavedLocation;
  final Future<String?> Function() onEnterManualAddress;

  const ChangeLocation({
    super.key,
    required this.addressController,
    required this.onGetCurrentLocation,
    required this.onUseSavedLocation,
    required this.onEnterManualAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextHeader(
                'Change Location',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.kBlack,
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ❇️ CURRENT LOCATION
          _option(
            icon: Icons.my_location,
            title: 'Use Current Location',
            subtitle: 'Get my GPS location',
            onTap: () async {
              Navigator.pop(context);
              await onGetCurrentLocation();
            },
          ),

          const Divider(height: 32),

          // ❇️ SAVED LOCATION FROM PROFILE BLOC
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded && state.user.pickupLocation != null) {
                return _option(
                  icon: Icons.bookmark,
                  title: 'Use Saved Location',
                  subtitle: state.user.pickupLocation!,
                  onTap: () {
                    Navigator.pop(context);
                    onUseSavedLocation(state.user.pickupLocation!);
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),

          const Divider(height: 32),

          // ❇️ ENTER MANUALLY
          _option(
            icon: Icons.edit_location,
            title: 'Enter Manually',
            subtitle: 'Type your address',
            onTap: () async {
              Navigator.pop(context);
              final value = await onEnterManualAddress();
              if (value != null) {
                addressController.text = value;
              }
            },
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _option({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.kPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.kPrimary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextHeader(
                    title,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.kBlack,
                  ),
                  const SizedBox(height: 4),
                  TextRegular(
                    subtitle,
                    fontSize: 12,
                    color: AppColors.kPayneGray,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
