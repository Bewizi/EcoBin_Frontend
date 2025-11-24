import 'package:ecobin/core/presentation/constants/images.dart';
import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_input_field.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/auth/presentation/widgets/mixins/success_to_dashboard.dart';
import 'package:ecobin/features/profile/domain/profile.dart';
import 'package:ecobin/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickupLocation extends StatefulWidget {
  const PickupLocation({super.key});

  static const String routeName = '/pickupLocation';

  @override
  State<PickupLocation> createState() => _PickupLocationState();
}

class _PickupLocationState extends State<PickupLocation>
    with SuccessToDashboardBottomSheet {
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _locationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

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
                      controller: _locationController,
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
                child: BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileLoaded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextRegular(
                            'Pickup location updated successfully!',
                            color: AppColors.kWhite,
                          ),
                          backgroundColor: AppColors.kPrimary,
                        ),
                      );
                      showSuccessToDashboardBottomSheet(context);
                    } else if (state is ProfileError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextRegular(
                            state.message,
                            color: AppColors.kWhite,
                          ),
                          backgroundColor: AppColors.kError500,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is ProfileLoading;
                    return CustomButton(
                      title: isLoading ? 'Saving...' : 'Continue',
                      bgColor: _locationController.text.isNotEmpty
                          ? AppColors.kPrimary
                          : AppColors.kHoneydew,
                      textColor: _locationController.text.isNotEmpty
                          ? AppColors.kWhite
                          : AppColors.kTealDeer,
                      onTap: (_locationController.text.isNotEmpty && !isLoading)
                          ? () {
                              context.read<ProfileBloc>().add(
                                CreateProfileEvent(
                                  Profile(
                                    fullName: null,
                                    avatar: null,
                                    pickupLocation: _locationController.text,
                                    userType: null,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.kWhite,
                              ),
                            )
                          : null,
                    );
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
