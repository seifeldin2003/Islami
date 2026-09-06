import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami/core/app_routes.dart';
import 'package:islami/core/app_strings.dart';
import 'package:islami/core/data/recent_suras_store.dart';
import 'package:islami/core/data/sura_repository.dart';
import 'package:islami/core/data/suras_data.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/modules/home/models/home_tab.dart';
import 'package:islami/modules/home/screens/home_screen.dart';
import 'package:islami/modules/quran/screens/quran_tab.dart';
import 'package:islami/modules/quran/screens/sura_details_screen.dart';
import 'package:islami/modules/radio/screens/radio_tab.dart';
import 'package:islami/modules/quran/widgets/recent_sura_card.dart';
import 'package:islami/modules/quran/widgets/sura_row.dart';

Future<void> _pumpHome(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.dark,
      home: const HomeScreen(),
      routes: const <String, WidgetBuilder>{
        AppRoutes.suraDetails: SuraDetailsScreen.fromRoute,
      },
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    RecentSurasStore.instance.reset();
  });

  testWidgets('the sura list renders and starts at Al-Fatiha', (tester) async {
    await _pumpHome(tester);

    expect(find.text('Al-Fatiha'), findsOneWidget);
    expect(find.text(AppStrings.verses(7)), findsOneWidget);
    expect(find.text(AppStrings.surasList), findsOneWidget);
  });

  testWidgets('searching filters the list, Arabic spelling included',
      (tester) async {
    await _pumpHome(tester);

    // The Figma mock-up types `الفاتحة`; the data set stores `الفاتحه`.
    await tester.enterText(find.byType(TextField), 'الفاتحة');
    await tester.pumpAndSettle();

    expect(find.byType(SuraRow), findsOneWidget);
    expect(find.text('Al-Fatiha'), findsOneWidget);
    // The section headings are hidden while searching.
    expect(find.text(AppStrings.surasList), findsNothing);
  });

  testWidgets('searching by English name is case-insensitive', (tester) async {
    await _pumpHome(tester);

    await tester.enterText(find.byType(TextField), 'baqarah');
    await tester.pumpAndSettle();

    expect(find.byType(SuraRow), findsOneWidget);
    expect(find.text('Al-Baqarah'), findsOneWidget);
  });

  testWidgets('opening a sura adds it to the Most Recently carousel',
      (tester) async {
    await _pumpHome(tester);

    expect(find.text(AppStrings.mostRecently), findsNothing);
    expect(find.byType(RecentSuraCard), findsNothing);

    // Opening a sura pushes the reader...
    await tester.runAsync(() => SuraRepository.versesOf(SurasData.all.first));
    await tester.tap(find.text('Al-Fatiha'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(SuraDetailsScreen), findsOneWidget);
    expect(RecentSurasStore.instance.recents.single.number, 1);

    // ...and on the way back the carousel is populated.
    await tester.tap(find.bySemanticsLabel(AppStrings.back));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text(AppStrings.mostRecently), findsOneWidget);
    expect(find.byType(RecentSuraCard), findsOneWidget);
  });

  testWidgets('a search with no matches says so instead of going blank',
      (tester) async {
    await _pumpHome(tester);

    await tester.enterText(find.byType(TextField), 'zzzzzz');
    await tester.pumpAndSettle();

    expect(find.byType(SuraRow), findsNothing);
    expect(find.text(AppStrings.noMatches), findsOneWidget);
  });

  testWidgets('clearing the search restores the full list', (tester) async {
    await _pumpHome(tester);

    await tester.enterText(find.byType(TextField), 'baqarah');
    await tester.pumpAndSettle();
    expect(find.byType(SuraRow), findsOneWidget);

    await tester.enterText(find.byType(TextField), '');
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.surasList), findsOneWidget);
    expect(find.byType(SuraRow), findsWidgets);
  });

  testWidgets('the bottom bar switches destinations', (tester) async {
    await _pumpHome(tester);

    expect(find.byType(QuranTab), findsOneWidget);
    expect(find.byType(RadioTab), findsNothing);

    await tester.tap(find.bySemanticsLabel(HomeTab.radio.label));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // The radio destination is now built, and the Qur'an tab no longer
    // shows the selected-tab label in the bar.
    expect(find.byType(RadioTab), findsOneWidget);
    expect(find.text(HomeTab.quran.label), findsNothing);
  });
}
