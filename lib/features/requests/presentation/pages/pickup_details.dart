import 'package:ecobin/core/di/injection.dart';
import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_back_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_input_field.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/core/services/location_service.dart';
import 'package:ecobin/features/auth/presentation/state/bloc/login_bloc.dart';
import 'package:ecobin/features/auth/presentation/state/bloc/register_bloc.dart';
import 'package:ecobin/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecobin/features/requests/presentation/state/bloc/pickup_bloc.dart';
import 'package:ecobin/features/requests/presentation/widgets/change_location.dart';
import 'package:ecobin/features/requests/presentation/widgets/mixins/successful_pickup_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PickupDetails extends StatefulWidget {
  const PickupDetails({super.key});

  static const String routeName = '/pickupDetails';

  @override
  State<PickupDetails> createState() => _PickupDetailsState();
}

class _PickupDetailsState extends State<PickupDetails>
    with SuccessfulPickupModal {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _address = TextEditingController();
  final TextEditingController _pickupDate = TextEditingController();
  final TextEditingController _pickupTime = TextEditingController();
  final TextEditingController _additionalNote = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isLoadingLocation = false;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
  }

  void _loadUserLocation() async {
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoaded) {
      if (profileState.user.pickupLocation != null) {
        _address.text = profileState.user.pickupLocation!;
      }
    } else {
      context.read<ProfileBloc>().add(const GetUserEvent());
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: _selectedDate ?? DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _pickupDate.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        final hour = picked.hour.toString().padLeft(2, '0');
        final minute = picked.minute.toString().padLeft(2, '0');
        _pickupTime.text = '$hour:$minute';
      });
    }
  }

  void _showChangeLocationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ChangeLocation(
        addressController: _address,
        onGetCurrentLocation: _getCurrentLocation,
        onUseSavedLocation: (loc) {
          setState(() => _address.text = loc);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: TextRegular(
                'Saved location loaded',
                color: AppColors.kWhite,
              ),
              backgroundColor: AppColors.kPrimary,
            ),
          );
        },
        onEnterManualAddress: () async {
          return await _showManualAddressDialog();
        },
      ),
    );
  }

  Future<String?> _showManualAddressDialog() async {
    final controller = TextEditingController(text: _address.text);

    return await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: TextHeader("Enter Address"),
        content: AppField(
          hintText: 'Enter your pickup address',
          controller: controller,
          maxLines: 3,
          minLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextRegular("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, controller.text.trim());
            },
            child: TextRegular("Confirm"),
          ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final position = await Injection.locationService.getCurrentPosition();

      _latitude = position.latitude;
      _longitude = position.longitude;

      final result = await Injection.geocodingService.reverseGeocode(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      if (result != null) {
        setState(() {
          _address.text = result.address;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: TextRegular(
                'Current location loaded successfully!',
                color: AppColors.kWhite,
              ),
              backgroundColor: AppColors.kPrimary,
            ),
          );
        }
      }
    }
    // on LocationServiceDisabledException catch (e) {
    //   _showLocationDialog(
    //     title: 'Location Services Disabled',
    //     message: e.toString(),
    //     actionText: 'Open Settings',
    //     onAction: () async {
    //       await Injection.locationService.openLocationSettings();
    //     },
    //   );
    // } on LocationPermissionDeniedException catch (e) {
    //   _showLocationDialog(
    //     title: 'Permission Denied',
    //     message: e.toString(),
    //     actionText: 'Request Again',
    //     onAction: _getCurrentLocation,
    //   );
    // } on LocationPermissionDeniedForeverException catch (e) {
    //   _showLocationDialog(
    //     title: 'Permission Denied',
    //     message: e.toString(),
    //     actionText: 'Open App Settings',
    //     onAction: () async {
    //       await Injection.locationService.openAppSettings();
    //     },
    //   );
    // }
    catch (e) {
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

  @override
  void dispose() {
    _address.dispose();
    _pickupDate.dispose();
    _pickupTime.dispose();
    _additionalNote.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(),
        backgroundColor: AppColors.kTransparent,
        automaticallyImplyLeading: false,
      ),
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

              SizedBox(height: 20),

              Expanded(
                child: BlocConsumer<PickupBloc, PickupState>(
                  listener: (context, state) {
                    if (state is PickupLoaded) {
                      showSuccessfulPickupModal(
                        context,
                        address: _address.text.trim(),
                        date: _pickupDate.text,
                        time: _pickupTime.text,
                        wasteType: 'Household Waste',
                        note: _additionalNote.text.trim(),
                      );
                    } else if (state is PickupError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextRegular(
                            state.message,
                            fontSize: 16,
                            color: AppColors.kWhite,
                          ),
                          backgroundColor: AppColors.kError500,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is PickupLoading;

                    return SingleChildScrollView(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocListener<ProfileBloc, ProfileState>(
                                  listener: (context, profileState) {
                                    if (profileState is ProfileLoaded &&
                                        _address.text.isEmpty) {
                                      if (profileState.user.pickupLocation !=
                                          null) {
                                        _address.text =
                                            profileState.user.pickupLocation!;
                                      }
                                    }
                                  },
                                  child: AppField(
                                    hintText:
                                        '03, Adekunmi Estate, Ojota Lago... ',
                                    title: 'Pickup Address',
                                    controller: _address,
                                    prefixIcons: SvgPicture.asset(
                                      AppSvgs.kGPS,
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    readOnly: true,
                                    onTap: _showChangeLocationBottomSheet,
                                  ),
                                ),
                                SizedBox(height: 12),
                                InkWell(
                                  onTap: _showChangeLocationBottomSheet,
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

                                      if (_isLoadingLocation)
                                        const SizedBox(width: 8),

                                      TextRegular(
                                        _isLoadingLocation
                                            ? 'Loading...'
                                            : 'Change Location',
                                        color: AppColors.kPrimary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColors.kPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 37),

                            Row(
                              children: [
                                Expanded(
                                  child: AppField(
                                    hintText: 'Pick A Date',
                                    title: 'Pickup Date',
                                    controller: _pickupDate,
                                    keyboardType: TextInputType.datetime,
                                    prefixIcons: Icon(
                                      Icons.calendar_month,
                                      size: 20,
                                    ),
                                    readOnly: true,
                                    onTap: () => _selectDate(context),
                                  ),
                                ),

                                SizedBox(width: 22),

                                Expanded(
                                  child: AppField(
                                    hintText: 'Pick A Time',
                                    title: 'Pickup Time',
                                    controller: _pickupTime,
                                    keyboardType: TextInputType.datetime,
                                    prefixIcons: Icon(
                                      Icons.access_time,
                                      size: 20,
                                    ),
                                    readOnly: true,
                                    onTap: () => _selectTime(context),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 37),

                            AppField(
                              hintText: 'Comment',
                              title: 'Additional Note',
                              controller: _additionalNote,
                              maxLines: 5,
                              minLines: 5,
                            ),

                            // Spacer(),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height *
                                  (101 / 640),
                            ),

                            // button
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomButton(
                                  title: 'Schedule Pickup',
                                  isDisabledBorder: false,
                                  bgColor: AppColors.kTransparent,
                                  onTap: () {},
                                  textColor: AppColors.kPrimary,
                                  fontWeight: FontWeight.w500,
                                ),

                                SizedBox(height: 20),

                                CustomButton(
                                  title: 'Confirm Pickup',
                                  isDisabledBorder: false,
                                  bgColor: AppColors.kPrimary,
                                  onTap: isLoading
                                      ? null
                                      : () {
                                          if (_formkey.currentState!
                                              .validate()) {
                                            final authSate = context
                                                .read<AuthBloc>()
                                                .state;
                                            final registerState = context
                                                .read<RegisterBloc>()
                                                .state;

                                            String? userId;
                                            if (authSate is AuthSuccess) {
                                              userId = authSate.user.id;
                                            } else if (registerState
                                                is RegisterSuccess) {
                                              userId = registerState.user.id;
                                            }
                                            if (userId != null) {
                                              context.read<PickupBloc>().add(
                                                CreatePickupEvent(
                                                  userId: userId,
                                                  address: _address.text.trim(),
                                                  pickupDate: _pickupDate.text,
                                                  pickupTime: _pickupTime.text,
                                                  additionalNote:
                                                      _additionalNote.text
                                                          .trim(),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: TextRegular(
                                                    'User not found, Please login again',
                                                  ),
                                                ),
                                              );
                                              return;
                                            }

                                            // context.read<PickupBloc>().add(
                                            //   CreatePickupEvent(
                                            //     userId: userId,
                                            //     address: _address.text.trim(),
                                            //     pickupDate: _pickupDate.text,
                                            //     pickupTime: _pickupTime.text,

                                            //     additionalNote: _additionalNote
                                            //         .text
                                            //         .trim(),
                                            //   ),
                                            // );
                                          }
                                        },
                                  textColor: AppColors.kWhite,
                                  fontWeight: FontWeight.w500,
                                  child: isLoading
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: AppColors.kWhite,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
