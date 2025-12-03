import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecobin/core/di/injection.dart';
import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/auth/presentation/pages/setup/user_type_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddProfilePicture extends StatefulWidget {
  const AddProfilePicture({super.key});

  static const String routeName = '/addProfilePicture';

  @override
  State<AddProfilePicture> createState() => _AddProfilePictureState();
}

class _AddProfilePictureState extends State<AddProfilePicture> {
  File? _imageFile;
  final ImagePicker picker = ImagePicker();
  bool _isUpLoading = false;

  Future<void> _uploadProfilePicture() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;
    setState(() {
      _isUpLoading = true;
    });

    try {
      String fileName = _imageFile!.path.split('/').last;
      FormData formData = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(
          _imageFile!.path,
          filename: fileName,
        ),
      });

      final response = await Injection.apiClient.post(
        'profile/avatar',
        data: formData,
      );

      if (response.statusCode == 200) {
        // Successfully uploaded
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile picture uploaded successfully'),
            ),
          );
          context.push(UserTypeOptions.routeName);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload profile picture: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUpLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHeader(
                      'Add a profile Picture',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: AppColors.kBlack,
                    ),
                    const SizedBox(height: 8),
                    AppRichText(
                      spans: [
                        TextSpan(
                          text: 'skip this for now',
                          style: TextStyle(color: AppColors.kPrimary),
                        ),
                      ],
                      text:
                          'Your photo helps us personalize your experience and\nallows our pickup team to easily identify you. You\ncan.',
                      color: AppColors.kPayneGray,
                      fontSize: 12,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                    // profile picture upload area
                    Center(
                      child: GestureDetector(
                        onTap: _uploadProfilePicture,
                        child: Container(
                          padding: _imageFile == null
                              ? EdgeInsets.all(25)
                              : EdgeInsets.all(150),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.kAntiFlashWhite,
                            image: _imageFile != null
                                ? DecorationImage(
                                    image: FileImage(_imageFile!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _imageFile == null
                              ? SvgPicture.asset(
                                  AppSvgs.kUserIcon,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.scaleDown,
                                )
                              : null,
                        ),
                      ),
                    ),

                    if (_imageFile != null)
                      Center(
                        child: TextButton(
                          onPressed: _uploadProfilePicture,
                          child: TextRegular(
                            'Change Photo',
                            fontSize: 14,
                            color: AppColors.kPayneGray,
                          ),
                        ),
                      ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    Column(
                      children: [
                        OutlinedCustomButton(
                          title: 'Skip for Now',
                          isDisabledBorder: false,
                          textColor: AppColors.kPrimary,
                          onTap: () {
                            context.push(UserTypeOptions.routeName);
                          },
                        ),
                        const SizedBox(height: 16),

                        // upload photo button
                        CustomButton(
                          title: _isUpLoading ? 'Uploading...' : 'Upload Photo',
                          bgColor: AppColors.kPrimary,
                          textColor: AppColors.kWhite,
                          onTap: _isUpLoading
                              ? null
                              : (_imageFile == null
                                    ? _uploadProfilePicture
                                    : _uploadImage),
                          child: _isUpLoading
                              ? SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: AppColors.kWhite,
                                    strokeWidth: 2,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.kMintCream,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextHeader(
                                      'Kindly note',
                                      fontSize: 14,
                                      color: AppColors.kBritishRacingGreen,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    const SizedBox(height: 8),

                                    TextRegular(
                                      'You can always update your photo later\nfrom settings.',
                                      fontSize: 12,
                                      color: AppColors.kBritishRacingGreen,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
