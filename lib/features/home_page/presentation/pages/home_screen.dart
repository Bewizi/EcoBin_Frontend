import 'package:ecobin/core/presentation/constants/images.dart';
import 'package:ecobin/core/presentation/constants/svgs.dart';
import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/app_button.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/home_page/presentation/widgets/date_card.dart';
import 'package:ecobin/features/home_page/presentation/widgets/pickup_action.dart';
import 'package:ecobin/features/home_page/presentation/widgets/schedule_pickup_info.dart';
import 'package:ecobin/features/navigation/page_navigation_bar.dart';
import 'package:ecobin/features/requests/domain/pickup.dart';
import 'package:ecobin/features/requests/presentation/pages/pickup_details.dart';
import 'package:ecobin/features/requests/presentation/pages/requests.dart';
import 'package:ecobin/features/requests/presentation/state/bloc/pickup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _pickUp = [
    {
      'title': 'Request Pickup',
      'icon': AppSvgs.kTrashIcon,
      'route': Requests.routeName,
    },
    {
      'title': 'Schedule Pickup',
      'icon': AppSvgs.kCalendarEdit,
      'route': PickupDetails.routeName,
    },
    {'title': 'Dropoff Points', 'icon': AppSvgs.kMap},
    {'title': 'View History', 'icon': AppSvgs.kNote},
  ];

  int _selectedDateIndex = 4;

  // greetings
  String getGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<PickupBloc>().add(const GetPickupEvent());
  }

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
                        getGreeting(),
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

                    SizedBox(height: 20),

                    BlocBuilder<PickupBloc, PickupState>(
                      builder: (context, state) {
                        if (state is PickupLoaded && state.pickups.isNotEmpty) {
                          final latestPickup = state.pickups.first;
                          return SchedulePickupInfo(
                            date: latestPickup.pickupDate ?? 'N/A',
                            time: latestPickup.pickupTime ?? 'N/A',
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.kAliceBlue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: BlocConsumer<PickupBloc, PickupState>(
                    listener: (context, state) {
                      if (state is PickupError) {
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
                      if (isLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      Pickup? latestPickup;
                      if (state is PickupLoaded && state.pickups.isNotEmpty) {
                        latestPickup = state.pickups.first;
                      }

                      if (latestPickup == null && state is PickupLoaded) {
                        return Center(
                          child: TextRegular('No upcoming pickups'),
                        );
                      }

                      return Column(
                        children: [
                          // Upcoming request and type
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextHeader(
                                'Upcoming Requests',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.kBlack,
                              ),

                              Row(
                                children: [
                                  TextRegular(
                                    'Type:',
                                    color: AppColors.kSlateGray,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.kLimeGreen,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AppImages.kRecycling,
                                          width: 16,
                                          height: 16,
                                        ),
                                        SizedBox(width: 8),
                                        TextRegular(
                                          'Recycle',
                                          fontSize: 12,
                                          color: AppColors.kBlack,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Date and time
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    size: 16,
                                    color: AppColors.kBlueSlate,
                                  ),
                                  SizedBox(width: 8),
                                  TextRegular(
                                    latestPickup?.pickupDate ?? 'N/A',
                                    color: AppColors.kBlueSlate,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: AppColors.kBlueSlate,
                                  ),
                                  SizedBox(width: 8),
                                  TextRegular(
                                    latestPickup?.pickupTime,
                                    color: AppColors.kBlueSlate,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Location
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.kMintCream,
                            ),
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
                                    latestPickup?.address,
                                    fontSize: 12,
                                    color: AppColors.kBritishRacingGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          CustomButton(
                            title: 'View Details',
                            bgColor: AppColors.kPrimary,
                            textColor: AppColors.kWhite,
                            onTap: () {
                              context.go(HomeScreen.routeName);
                            },
                          ),
                        ],
                      );
                    },
                  ),
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
                    title: action['title'] as String,
                    icon: action['icon'] as String,
                    onTap: () {
                      final routes = action['route'];
                      if (routes != null) {
                        context.push(routes);
                      }
                    },
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
