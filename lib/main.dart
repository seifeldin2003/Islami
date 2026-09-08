import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/app_routes.dart';
import 'core/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'modules/home/screens/home_screen.dart';
import 'modules/hadeth/screens/hadith_details_screen.dart';
import 'modules/intro/screens/intro_screen.dart';
import 'modules/quran/screens/sura_details_screen.dart';
import 'modules/times/screens/azkar_details_screen.dart';
import 'modules/splash/screens/splash_screen.dart';

/// The artboard every screen is authored against.
const Size kDesignSize = Size(430, 932);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(const IslamiApp());
}

class IslamiApp extends StatelessWidget {
  const IslamiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: kDesignSize,
      minTextAdapt: true,
      child: MaterialApp(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        initialRoute: AppRoutes.splash,
        routes: <String, WidgetBuilder>{
          AppRoutes.splash: (_) => const SplashScreen(),
          AppRoutes.intro: (_) => const IntroScreen(),
          AppRoutes.home: (_) => const HomeScreen(),
          AppRoutes.suraDetails: SuraDetailsScreen.fromRoute,
          AppRoutes.hadithDetails: HadithDetailsScreen.fromRoute,
          AppRoutes.azkarDetails: AzkarDetailsScreen.fromRoute,
        },
      ),
    );
  }
}
