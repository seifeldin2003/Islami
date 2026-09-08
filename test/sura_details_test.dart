import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_harness.dart';
import 'package:islami/core/app_routes.dart';
import 'package:islami/core/data/recent_suras_store.dart';
import 'package:islami/core/data/sura_repository.dart';
import 'package:islami/core/data/suras_data.dart';
import 'package:islami/core/models/sura.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/modules/home/screens/home_screen.dart';
import 'package:islami/modules/quran/screens/sura_details_screen.dart';
import 'package:islami/modules/quran/widgets/verse_card.dart';

/// Warms the verse cache before pumping.
///
/// Reading the asset is real I/O, so it has to run through
/// [WidgetTester.runAsync] — inside the fake-async zone it never completes.
/// Once the cache is warm the `FutureBuilder` resolves on the next frame,
/// which also avoids `pumpAndSettle` spinning forever on the loading
/// indicator's animation.
Future<void> _pumpDetails(WidgetTester tester, Sura sura) async {
  // The verse list is lazy, so the default 800x600 surface would only build
  // the first few cards; give it room for all of Al-Fatiha.
  tester.view.physicalSize = const Size(430, 2000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.runAsync(() => SuraRepository.versesOf(sura));
  await tester.pumpWidget(
    scaled(
        MaterialApp(theme: AppTheme.dark, home: SuraDetailsScreen(sura: sura))),
  );
  await tester.pump();
  await tester.pump();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    RecentSurasStore.instance.reset();
    SuraRepository.clearCache();
  });

  test('the reader strips the byte-order mark off the first verse', () async {
    final verses = await SuraRepository.versesOf(SurasData.all.first);

    expect(verses.first.codeUnitAt(0), isNot(0xFEFF));
    expect(verses.first, startsWith('بِسْمِ'));
    expect(verses, hasLength(7));
  });

  test('verses are cached after the first read', () async {
    final first = await SuraRepository.versesOf(SurasData.all[1]);
    final second = await SuraRepository.versesOf(SurasData.all[1]);

    expect(identical(first, second), isTrue);
    expect(first, hasLength(286));
  });

  testWidgets('the reader renders one card per verse', (tester) async {
    await _pumpDetails(tester, SurasData.all.first);

    expect(find.text('Al-Fatiha'), findsOneWidget); // app bar
    expect(find.text('الفاتحه'), findsOneWidget); // Arabic heading
    expect(find.byType(VerseCard), findsNWidgets(7));
  });

  testWidgets('each card is numbered from one', (tester) async {
    await _pumpDetails(tester, SurasData.all.first);

    final cards = tester.widgetList<VerseCard>(find.byType(VerseCard));
    expect(cards.map((c) => c.number), List<int>.generate(7, (i) => i + 1));
    expect(cards.first.text, startsWith('بِسْمِ'));
  });

  testWidgets('tapping a sura on the home screen opens its reader',
      (tester) async {
    await tester.pumpWidget(
      scaled(MaterialApp(
        theme: AppTheme.dark,
        home: const HomeScreen(),
        routes: const <String, WidgetBuilder>{
          AppRoutes.suraDetails: SuraDetailsScreen.fromRoute,
        },
      )),
    );
    await tester.pumpAndSettle();

    await tester.runAsync(() => SuraRepository.versesOf(SurasData.all.first));
    await tester.tap(find.text('Al-Fatiha'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(find.byType(SuraDetailsScreen), findsOneWidget);
    expect(find.byType(VerseCard), findsWidgets);
    // ...and it was recorded as recently opened.
    expect(RecentSurasStore.instance.recents.single.number, 1);
  });
}
