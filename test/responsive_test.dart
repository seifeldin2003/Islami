import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami/core/data/hadith_repository.dart';
import 'package:islami/core/data/radio_repository.dart';
import 'package:islami/core/data/recent_suras_store.dart';
import 'package:islami/core/data/sura_repository.dart';
import 'package:islami/core/data/suras_data.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/modules/hadeth/screens/hadeth_tab.dart';
import 'package:islami/modules/home/screens/home_screen.dart';
import 'package:islami/modules/intro/screens/intro_screen.dart';
import 'package:islami/modules/quran/screens/sura_details_screen.dart';
import 'package:islami/modules/sebha/screens/sebha_tab.dart';
import 'package:islami/modules/splash/screens/splash_screen.dart';
import 'test_harness.dart';

/// Screen sizes the layout has to survive, in logical pixels.
const Map<String, Size> _surfaces = <String, Size>{
  'small phone (iPhone SE)': Size(320, 568),
  'common phone (Pixel 5)': Size(393, 851),
  'design artboard': Size(430, 932),
  'tall phone': Size(412, 960),
  'small tablet': Size(600, 1024),
  'large tablet': Size(768, 1024),
  'landscape phone': Size(852, 393),
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    RecentSurasStore.instance.reset();
    SuraRepository.clearCache();
    HadithRepository.clearCache();
    RadioRepository.clearCache();
  });

  /// Pumps [build] at every surface and fails on the first layout overflow.
  Future<void> checkEverySurface(
    WidgetTester tester,
    Widget Function() build,
  ) async {
    for (final entry in _surfaces.entries) {
      useDesignSurface(tester, size: entry.value);
      await tester.pumpWidget(const SizedBox.shrink());
      await pumpScaled(tester, build());
      await tester.pump(const Duration(milliseconds: 400));

      expect(
        tester.takeException(),
        isNull,
        reason: 'laid out badly on ${entry.key} (${entry.value})',
      );
    }
  }

  testWidgets('the splash survives every screen size', (tester) async {
    await checkEverySurface(
      tester,
      () =>
          scaled(MaterialApp(theme: AppTheme.dark, home: const SplashScreen())),
    );
  });

  testWidgets('the intro survives every screen size', (tester) async {
    await checkEverySurface(
      tester,
      () =>
          scaled(MaterialApp(theme: AppTheme.dark, home: const IntroScreen())),
    );
  });

  testWidgets('the home shell survives every screen size', (tester) async {
    await checkEverySurface(
      tester,
      () => scaled(MaterialApp(theme: AppTheme.dark, home: const HomeScreen())),
    );
  });

  testWidgets('the sura reader survives every screen size', (tester) async {
    await tester.runAsync(() => SuraRepository.versesOf(SurasData.all.first));
    await checkEverySurface(
      tester,
      () => scaled(
        MaterialApp(
          theme: AppTheme.dark,
          home: SuraDetailsScreen(sura: SurasData.all.first),
        ),
      ),
    );
  });

  testWidgets('the hadeth carousel survives every screen size', (tester) async {
    await tester.runAsync(HadithRepository.all);
    await checkEverySurface(
      tester,
      () => scaled(
        MaterialApp(
          theme: AppTheme.dark,
          home: Scaffold(body: HadethTab(onHadithSelected: (_) {})),
        ),
      ),
    );
  });

  testWidgets('the sebha survives every screen size', (tester) async {
    await checkEverySurface(
      tester,
      () => scaled(
        MaterialApp(
          theme: AppTheme.dark,
          home: const Scaffold(body: SebhaTab()),
        ),
      ),
    );
  });
}
