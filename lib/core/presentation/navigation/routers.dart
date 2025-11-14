import 'package:ecobin/features/activities/activities.dart';
import 'package:ecobin/features/auth/presentation/pages/setup/add_profile_picture.dart';
import 'package:ecobin/features/auth/presentation/pages/setup/pickup_location.dart';
import 'package:ecobin/features/auth/presentation/pages/setup/user_type_options.dart';
import 'package:ecobin/features/auth/presentation/pages/signIn/sign_in.dart';
import 'package:ecobin/features/auth/presentation/pages/signUp/sign_up.dart';
import 'package:ecobin/features/home_page/presentation/pages/home_screen.dart';
import 'package:ecobin/features/profile/presentation/pages/profile.dart';
import 'package:ecobin/features/requests/presentation/pages/household_details.dart';
import 'package:ecobin/features/requests/presentation/pages/pickup_details.dart';
import 'package:ecobin/features/requests/presentation/pages/requests.dart';
import 'package:ecobin/features/splash_screens/splash_screen_logo.dart';
import 'package:ecobin/features/splash_screens/splash_screens.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: HomeScreen.routeName,
  routes: [
    GoRoute(
      path: SplashScreenLogo.routeName,
      name: 'splashScreenLogo',
      builder: (context, state) => const SplashScreenLogo(),
    ),
    GoRoute(
      path: SplashScreens.routeName,
      name: 'splashScreens',
      builder: (context, state) => const SplashScreens(),
    ),
    GoRoute(
      path: SignIn.routeName,
      name: 'signIn',
      builder: (context, state) => const SignIn(),
    ),

    GoRoute(
      path: SignUp.routeName,
      name: 'signUp',
      builder: (context, state) => const SignUp(),
    ),

    GoRoute(
      path: AddProfilePicture.routeName,
      name: 'addProfilePicture',
      builder: (context, state) => const AddProfilePicture(),
    ),

    GoRoute(
      path: UserTypeOptions.routeName,
      name: 'userTypeOptions',
      builder: (context, state) => const UserTypeOptions(),
    ),

    GoRoute(
      path: PickupLocation.routeName,
      name: 'pickupLocation',
      builder: (context, state) => const PickupLocation(),
    ),

    GoRoute(
      path: HomeScreen.routeName,
      name: 'homeScreen',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: Activities.routeName,
      name: 'activities',
      builder: (context, state) => const Activities(),
    ),

    GoRoute(
      path: Requests.routeName,
      name: 'requests',
      builder: (context, state) => const Requests(),
    ),

    GoRoute(
      path: HouseholdDetails.routeName,
      name: 'householdDetails',
      builder: (context, state) => const HouseholdDetails(),
    ),

    GoRoute(
      path: PickupDetails.routeName,
      name: 'pickupDetails',
      builder: (context, state) => const PickupDetails(),
    ),

    GoRoute(
      path: Profile.routeName,
      name: 'profile',
      builder: (context, state) => const Profile(),
    ),
  ],
);
