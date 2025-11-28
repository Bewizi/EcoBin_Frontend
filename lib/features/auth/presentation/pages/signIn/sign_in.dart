import 'package:ecobin/core/presentation/constants/images.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_input_field.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/auth/presentation/pages/signUp/sign_up.dart';
import 'package:ecobin/features/auth/presentation/state/bloc/login_bloc.dart';
import 'package:ecobin/features/auth/util/password_visible.dart';
import 'package:ecobin/features/home_page/presentation/pages/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  static const String routeName = '/signIn';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  void _togglePasswordVisisble() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthSate>(
          listener: (context, state) {
            if (state is AuthLoading) {
              Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimary,
                  backgroundColor: AppColors.kBlack.withValues(alpha: 0.5),
                ),
              );
            } else if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: TextRegular(
                    'Welcome back, ${state.user.fullName}!',
                    color: AppColors.kWhite,
                    fontSize: 18,
                  ),
                  backgroundColor: AppColors.kBritishRacingGreen,
                ),
              );

              context.go(HomeScreen.routeName);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: TextRegular(state.message),
                  backgroundColor: AppColors.kError500,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.20,
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
                                  'Welcome Back!',
                                  color: AppColors.kWhite,
                                ),
                                const SizedBox(height: 12),
                                TextRegular(
                                  'Fill the form below to continue.',
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
                      key: _formKey,
                      child: Column(
                        children: [
                          // email field
                          AppField(
                            controller: _emailController,
                            hintText: 'Ecobin@gmail.com',
                            title: 'Email Address',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your emaul';
                              }
                              if (!value.contains('@')) {
                                return 'Invalid email address';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          // password field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppField(
                                controller: _passwordController,
                                hintText: 'Enter a strong password',
                                title: 'Password',
                                obscureText: _obscureText,
                                suffix: PasswordVisible(
                                  isObscured: _obscureText,
                                  onToggle: _togglePasswordVisisble,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 8) {
                                    return 'Password must be at least 8 characters above';
                                  }
                                  if (value.length > 20) {
                                    return 'Password must be at most not be more 20 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: TextRegular(
                                    'Forgot Password?',
                                    color: AppColors.kPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 84),
                          // submit button
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomButton(
                                title: 'Log In',
                                onTap: isLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<AuthBloc>().add(
                                            LoginRequested(
                                              email: _emailController.text
                                                  .trim(),
                                              password:
                                                  _passwordController.text,
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

                              const SizedBox(height: 11),
                              Align(
                                alignment: Alignment.center,
                                child: AppRichText(
                                  text: 'Don\'t have an account?',
                                  color: AppColors.kPayneGray,
                                  fontSize: 14,
                                  spans: [
                                    TextSpan(
                                      text: ' Sign Up',
                                      style: TextStyle(
                                        color: AppColors.kPrimary,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Navigate to SignUp
                                          context.go(SignUp.routeName);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
