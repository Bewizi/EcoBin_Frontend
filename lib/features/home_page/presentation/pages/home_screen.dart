import 'package:ecobin/core/di/injection.dart';
import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/auth/presentation/pages/signIn/sign_in.dart';
import 'package:ecobin/features/home_page/presentation/widgets/date_card.dart';
import 'package:ecobin/features/home_page/presentation/widgets/pickup_action.dart';
import 'package:ecobin/features/navigation/page_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _pickUp = [
    {'title': 'Request Pickup', 'icon': AppSvgs.kTrashIcon},
    {'title': 'Schedule Pickup', 'icon': AppSvgs.kCalendarEdit},
    {'title': 'Dropoff Points', 'icon': AppSvgs.kMap},
    {'title': 'View History', 'icon': AppSvgs.kNote},
  ];

  int _selectedDateIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PageNavigationBar(currentIndex: 0),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              toolbarHeight: 80,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHeader(
                        'Good Morning,',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.kBlack,
                      ),
                      const SizedBox(height: 8),
                      TextRegular(
                        'It’s sunny 🌞️, perfect day to take\nout your bin!',

                        fontWeight: FontWeight.w500,
                        color: AppColors.kPayneGray,
                      ),
                    ],
                  ),

                  const Spacer(),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1540569014015-19a7be504e3a?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=735',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.logout, color: AppColors.kError),
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
                              ScaffoldMessenger.of(context).showSnackBar(
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
            ),

            // SizedBox(height: 25),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHeader(
                      'Next Pickup',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.kBlack,
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          final date = DateTime.now().add(
                            Duration(days: index),
                          );
                          return DateCard(
                            date: date,
                            isSelected: _selectedDateIndex == index,
                            onTap: () {
                              setState(() {
                                _selectedDateIndex = index;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.only(top: 27, left: 20, right: 20),
              sliver: SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 12.0,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (context, index) {
                  final action = _pickUp[index];
                  return PickupAction(
                    title: action['title']!,
                    icon: action['icon']!,
                    onTap: () {},
                  );
                },
                itemCount: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
