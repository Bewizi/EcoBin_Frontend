import 'package:ecobin/core/di/injection.dart';
import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/auth/presentation/pages/signIn/sign_in.dart';
import 'package:ecobin/features/navigation/page_navigation_bar.dart';
import 'package:ecobin/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecobin/features/profile/presentation/widgets/user_avatar.dart';
import 'package:ecobin/features/requests/presentation/state/bloc/pickup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  static const String routeName = '/profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const GetUserEvent());
  }

  void _showLocationDetails(BuildContext context, String? location) {
    if (location == null || location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No location set'),
          backgroundColor: AppColors.kError500,
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.kPrimary, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: TextHeader(
                    'Your Location',
                    fontSize: 18,
                    color: AppColors.kBlack,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.kAliceBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextRegular(
                location,
                fontSize: 14,
                color: AppColors.kBlack,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextHeader(
          'Profile',
          fontWeight: FontWeight.w500,
          color: AppColors.kBlack,
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: PageNavigationBar(currentIndex: 3),
      body: SingleChildScrollView(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Skeletonizer(
              enabled: state is ProfileLoading,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 107,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // profile.dart - Update the avatar section
                          const UserAvatar(size: 100, iconSize: 50),

                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // User FullName
                                TextHeader(
                                  (state is ProfileLoaded)
                                      ? state.user.fullName
                                      : "Placeholder Name",
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.kBlack,
                                ),

                                SizedBox(height: 12),
                                // location
                                GestureDetector(
                                  onTap: () {
                                    if (state is ProfileLoaded) {
                                      _showLocationDetails(
                                        context,
                                        state.user.pickupLocation,
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppSvgs.kLocationIcon,
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: TextRegular(
                                          (state is ProfileLoaded &&
                                                  state.user.pickupLocation !=
                                                      null)
                                              ? _truncateLocation(
                                                  state.user.pickupLocation!,
                                                )
                                              : 'No location set',
                                          color: AppColors.kBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                      if (state is ProfileLoaded &&
                                          state.user.pickupLocation != null)
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 12,
                                          color: AppColors.kPayneGray,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHeader(
                            'Preferences',
                            color: AppColors.kBlack,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                          SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: AppColors.kAliceBlue,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Row(
                                        children: [
                                          //  icon
                                          SvgPicture.asset(
                                            AppSvgs.kLocationIcon,
                                            width: 24,
                                            height: 24,
                                            fit: BoxFit.scaleDown,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: TextRegular(
                                              (state is ProfileLoaded &&
                                                      state
                                                              .user
                                                              .pickupLocation !=
                                                          null)
                                                  ? state.user.pickupLocation!
                                                  : '10 block, Majek Estate, Ibafo. Lagos state Nigeria',
                                              fontSize: 16,
                                              color: AppColors.kBlack,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: TextRegular(
                                        'Edit',
                                        color: AppColors.kBlueSlate,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            size: 16,
                                            color: AppColors.kBlueSlate,
                                          ),
                                          SizedBox(width: 8),
                                          BlocConsumer<PickupBloc, PickupState>(
                                            listener: (context, state) {
                                              if (state is PickupError) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      state.message,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            builder: (context, state) {
                                              return TextRegular(
                                                '9 AM - Thursays',
                                                color: AppColors.kBlack,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: TextRegular(
                                        'Change',
                                        color: AppColors.kBlueSlate,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildBox(
                            AppSvgs.kSettingLineLight,
                            'App Settings',
                            AppSvgs.kArrowOutlined,
                          ),
                          SizedBox(height: 20),
                          _buildBox(
                            AppSvgs.kHelpSupport,
                            'Help & Support',
                            AppSvgs.kArrowOutlined,
                          ),
                          SizedBox(height: 20),
                          _buildBox(
                            AppSvgs.kProiconsNote,
                            'Terms & Privacy',
                            AppSvgs.kArrowOutlined,
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextRegular(
                                'Logout',
                                color: AppColors.kBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.logout,
                                  color: AppColors.kError,
                                ),
                                onPressed: () async {
                                  try {
                                    // Show loading dialog
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );

                                    // Perform logout
                                    await Injection.authRepository.logout();

                                    // Navigate to login screen and clear the stack
                                    if (context.mounted) {
                                      context.go(SignIn.routeName);
                                    }
                                  } catch (e) {
                                    // Close loading dialog
                                    if (context.mounted) {
                                      Navigator.pop(context);

                                      // Show error snackbar
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('Logout failed: \$e'),
                                          backgroundColor: AppColors.kError,
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _truncateLocation(String location) {
    if (location.length <= 40) return location;
    return '${location.substring(0, 37)}...';
  }
}

Widget _buildBox(String icon, String title, String arrowIcon) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 6,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(width: 8),
            TextRegular(
              title,
              color: AppColors.kBlack,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      Expanded(
        child: SvgPicture.asset(
          arrowIcon,
          width: 24,
          height: 24,
          fit: BoxFit.scaleDown,
        ),
      ),
    ],
  );
}
