import 'package:ecobin/core/di/injection.dart';
import 'package:ecobin/core/presentation/constants/images.dart';
import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_input_field.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/core/services/location_service.dart';
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
  bool _isLoadingLocation = false;
  double? _latitude;
  double? _longitude;

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

  Future<void> _getUserLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      // Get current position
      final position = await Injection.locationService.getCurrentPosition();

      _latitude = position.latitude;
      _longitude = position.longitude;

      // Get address from coordinates
      final result = await Injection.geocodingService.reverseGeocode(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      if (result != null) {
        setState(() {
          _locationController.text = result.address;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: TextRegular(
                'Location detected Successfully!',
                color: AppColors.kWhite,
              ),
              backgroundColor: AppColors.kBritishRacingGreen,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        throw Exception('Could not get address from coordinates');
      }
    } on LocationServiceDisabledException catch (e) {
      _showLocationDialog(
        title: 'Location Services Disabled',
        message: e.toString(),
        actionText: 'Open Settings',
        onAction: () async {
          await Injection.locationService.openLocationSettings();
        },
      );
    } on LocationPermissionDeniedException catch (e) {
      _showLocationDialog(
        title: 'Permission Denied',
        message: e.toString(),
        actionText: 'Request Again',
        onAction: () async {
          await _getUserLocation();
        },
      );
    } on LocationPermissionDeniedForeverException catch (e) {
      _showLocationDialog(
        title: 'Permission Denied',
        message: e.toString(),
        actionText: 'Open App Settings',
        onAction: () async {
          await Injection.locationService.openAppSettings();
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: TextRegular(
              'Failed to get location: ${e.toString()}',
              color: AppColors.kWhite,
            ),
            backgroundColor: AppColors.kError500,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingLocation = false;
        });
      }
    }
  }

  void _showLocationDialog({
    required String title,
    required String message,
    required String actionText,
    required VoidCallback onAction,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: TextHeader(title, fontSize: 18, color: AppColors.kBlack),
        content: TextRegular(
          message,
          fontSize: 14,
          color: AppColors.kPayneGray,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextRegular('Cancel', color: AppColors.kPayneGray),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onAction();
            },
            child: TextRegular(
              actionText,
              color: AppColors.kPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
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
                      enabled: !_isLoadingLocation,
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
                onTap: _isLoadingLocation ? null : _getUserLocation,
                child: Row(
                  children: [
                    if (_isLoadingLocation)
                      const SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.kPrimary,
                        ),
                      ),

                    if (_isLoadingLocation) const SizedBox(width: 8),
                    TextRegular(
                      _isLoadingLocation
                          ? 'Getting your location...'
                          : 'Use my Location',
                      color: _isLoadingLocation
                          ? AppColors.kPayneGray
                          : AppColors.kPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              if (_latitude != null && _longitude != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.kHoneydew.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.kPrimary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.kPrimary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextRegular(
                              'Coordinates detected',
                              fontSize: 10,
                              color: AppColors.kPayneGray,
                            ),
                            TextRegular(
                              'Lat: ${_latitude!.toStringAsFixed(6)}, Lng: ${_longitude!.toStringAsFixed(6)}',
                              fontSize: 11,
                              color: AppColors.kBlack,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              const Spacer(),

              BlocConsumer<ProfileBloc, ProfileState>(
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

              // SizedBox(height: MediaQuery.of(context).size.height * 0.2),

              // Flexible(
              //   child:
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
