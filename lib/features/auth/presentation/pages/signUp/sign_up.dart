import 'package:ecobin/core/presentation/constants/images.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_input_field.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/auth/presentation/pages/signIn/sign_in.dart';
import 'package:ecobin/features/auth/presentation/state/bloc/register_bloc.dart';
import 'package:ecobin/features/auth/presentation/widgets/mixins/success_message.dart';
import 'package:ecobin/features/auth/util/password_visible.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static const String routeName = '/signUp';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SuccessMessageBottomSheet {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _fullNamController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _hasMinLenght = false;
  bool _hasUppercase = false;
  bool _hasSPecialChar = false;
  bool _hasNumber = false;

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final password = _passwordController.text;
    setState(() {
      _hasMinLenght = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasSPecialChar = password.contains(RegExp(r'[!@#$%*<>&.=+"|{}]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
    });
  }

  void _togglePasswordVisisble() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: TextRegular('Welcome, ${state.user.fullName}'),
                  backgroundColor: AppColors.kBritishRacingGreen,
                ),
              );
              showSuccessMessageBottomSheet(context);
            } else if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },

          builder: (context, state) {
            final isLoading = state is RegisterLoading;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300.h,
                    decoration: BoxDecoration(color: AppColors.kPrimary),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ClipRRect(
                              child: Image.asset(AppImages.kPaperRecycle),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50, left: 19),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextHeader(
                                  'Let’s Get You Started',
                                  color: AppColors.kWhite,
                                ),
                                const SizedBox(height: 12),
                                TextRegular(
                                  'Create an account to keep your\nenvironment clean.',
                                  color: AppColors.kWhite,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppField(
                            hintText: 'Enter your full name',
                            title: 'Full Name',
                            controller: _fullNamController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your full name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppField(
                            hintText: 'Ecobin@gmail.com',
                            title: 'Email Address',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value)) {
                                return 'Please enter a valid email format';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppField(
                            hintText: 'Enter your phone number',
                            title: 'Phone Number',
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number';
                              }
                              if (value.length < 11) {
                                return 'Phone number must be least than 11 digits';
                              }
                              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return 'Phone number can only contain digits';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          AppField(
                            hintText: 'Enter a strong password',
                            title: 'Password',
                            obscureText: _obscureText,
                            suffix: PasswordVisible(
                              isObscured: _obscureText,
                              onToggle: _togglePasswordVisisble,
                            ),

                            // keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (!_hasMinLenght ||
                                  !_hasUppercase ||
                                  !_hasSPecialChar ||
                                  !_hasNumber) {
                                return 'Password doesn\'t meet requirements';
                              }
                              // if (value.length > 20) {
                              //   return 'Password must be at most not be more 20 characters';
                              // }
                              return null;
                            },
                            controller: _passwordController,
                          ),

                          const SizedBox(height: 16),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextHeader(
                                'Password must contain:',
                                color: AppColors.kRaisinBlack,
                                fontSize: 12,
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  _buildPasswordRequirement(
                                    '8 characters',
                                    _hasMinLenght,
                                    context,
                                  ),
                                  _buildPasswordRequirement(
                                    ' 1 uppercase letter',
                                    _hasUppercase,
                                    context,
                                  ),
                                  _buildPasswordRequirement(
                                    ' 1 special character (e.g., ! @ #  %)',
                                    _hasSPecialChar,
                                    context,
                                  ),
                                  _buildPasswordRequirement(
                                    '1 number',
                                    _hasNumber,
                                    context,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // submit button
                          CustomButton(
                            title: 'Create Account',
                            onTap: isLoading
                                ? null
                                : () {
                                    if (_formkey.currentState!.validate()) {
                                      context.read<RegisterBloc>().add(
                                        RegisterRequested(
                                          fullName: _fullNamController.text
                                              .trim(),
                                          email: _emailController.text.trim(),
                                          phoneNumber: _phoneNumberController
                                              .text
                                              .trim(),
                                          password: _passwordController.text,
                                        ),
                                      );
                                    }
                                  },
                            child: isLoading
                                ? const SizedBox(
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
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 11),
                        Align(
                          alignment: Alignment.center,
                          child: AppRichText(
                            text: 'By signing up, you agree to EcoBin’s',
                            color: AppColors.kPayneGray,
                            fontSize: 14,
                            spans: [
                              TextSpan(
                                text: ' Terms of\nService ',
                                style: TextStyle(color: AppColors.kPrimary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to SignUp
                                    context.go(SignUp.routeName);
                                  },
                              ),
                              TextSpan(
                                text: ' and',
                                style: TextStyle(color: AppColors.kBlack),
                              ),
                              TextSpan(
                                text: ' Privacy Policy.',
                                style: TextStyle(color: AppColors.kPrimary),
                              ),
                            ],
                            textAlign: TextAlign.center,
                          ),
                        ),

                        const SizedBox(height: 11),
                        Align(
                          alignment: Alignment.center,
                          child: AppRichText(
                            text: 'Have an account?',
                            fontSize: 14,
                            color: AppColors.kPayneGray,
                            spans: [
                              TextSpan(
                                text: ' Sign In',
                                style: TextStyle(color: AppColors.kPrimary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to SignUp
                                    context.go(SignIn.routeName);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildPasswordRequirement(
  String text,
  bool isMet,
  BuildContext context,
) {
  return Container(
    constraints: BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width * 0.7,
    ),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: isMet ? AppColors.kPrimary : AppColors.kFrenchGray,
      ),
      borderRadius: BorderRadius.circular(80),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check,
          size: 12,
          color: isMet ? AppColors.kPrimary : AppColors.kFrenchGray,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: TextRegular(
            text,
            color: isMet ? AppColors.kPrimary : AppColors.kSlateGray,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
