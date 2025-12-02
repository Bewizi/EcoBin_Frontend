import 'package:device_preview/device_preview.dart';
import 'package:ecobin/core/di/injection.dart';
import 'package:ecobin/core/presentation/navigation/routers.dart';
import 'package:ecobin/core/presentation/themes/themes_data.dart';
import 'package:ecobin/features/auth/presentation/state/bloc/register_bloc.dart';
import 'package:ecobin/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecobin/features/requests/presentation/state/bloc/pickup_bloc.dart';
import 'package:ecobin/features/requests/presentation/state/bloc/waste_type_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Injection.init();

  runApp(
    //   DevicePreview(enabled: !kReleaseMode, builder: (context) =>
    // )
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 997),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => Injection.authBloc),
            BlocProvider(
              create: (context) =>
                  RegisterBloc(repository: Injection.authRepository),
            ),
            BlocProvider(
              create: (context) =>
                  ProfileBloc(repository: Injection.profileRepository),
            ),
            BlocProvider(
              create: (context) =>
                  PickupBloc(repository: Injection.pickupRepository),
            ),

            BlocProvider(
              create: (context) =>
                  WasteTypeBloc(repository: Injection.wasteTypeRepository),
            ),
          ],
          child: MaterialApp.router(
            // locale: DevicePreview.locale(context),
            // builder: DevicePreview.appBuilder,
            // useInheritedMediaQuery: true,
            routerConfig: appRouter,
            theme: AppThemesData.lightTheme(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
