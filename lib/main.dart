import 'package:flutter/material.dart';

import 'core/app_routes.dart';
import 'core/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'modules/home/screens/home_screen.dart';
import 'modules/hadeth/screens/hadith_details_screen.dart';
import 'modules/intro/screens/intro_screen.dart';
import 'modules/quran/screens/sura_details_screen.dart';
import 'modules/times/screens/azkar_details_screen.dart';
import 'modules/splash/screens/splash_screen.dart';

void main() {
  runApp(const IslamiApp());
}

class IslamiApp extends StatelessWidget {
  const IslamiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.intro: (_) => const IntroScreen(),
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.suraDetails: SuraDetailsScreen.fromRoute,
        AppRoutes.hadithDetails: HadithDetailsScreen.fromRoute,
        AppRoutes.azkarDetails: AzkarDetailsScreen.fromRoute,
      },
    );
  }
}
