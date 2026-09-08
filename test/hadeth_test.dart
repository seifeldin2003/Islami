import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_harness.dart';
import 'package:islami/core/app_routes.dart';
import 'package:islami/core/app_strings.dart';
import 'package:islami/core/data/hadith_repository.dart';
import 'package:islami/core/models/hadith.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/modules/hadeth/screens/hadeth_tab.dart';
import 'package:islami/modules/hadeth/screens/hadith_details_screen.dart';
import 'package:islami/modules/hadeth/widgets/hadith_card.dart';

Future<List<Hadith>> _warm(WidgetTester tester) async {
  // Reading 50 bundled files is real I/O, so it must run outside the
  // fake-async zone.
  return (await tester.runAsync(HadithRepository.all))!;
}

Future<void> _pumpTab(WidgetTester tester) async {
  tester.view.physicalSize = const Size(430, 932);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await _warm(tester);
  await tester.pumpWidget(
    scaled(MaterialApp(
      theme: AppTheme.dark,
      home: Scaffold(body: HadethTab(onHadithSelected: (_) {})),
      routes: const <String, WidgetBuilder>{
        AppRoutes.hadithDetails: HadithDetailsScreen.fromRoute,
      },
    )),
  );
  await tester.pump();
  await tester.pump();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(HadithRepository.clearCache);

  test('the collection holds fifty hadiths with a title and a body', () async {
    final hadiths = await HadithRepository.all();

    expect(hadiths, hasLength(HadithRepository.count));
    for (final hadith in hadiths) {
      expect(hadith.title, isNotEmpty, reason: 'hadith ${hadith.number}');
      expect(hadith.paragraphs, isNotEmpty, reason: 'hadith ${hadith.number}');
      expect(hadith.body.trim(), isNotEmpty);
    }
  });

  test('the doubled byte-order mark is stripped from the title', () async {
    final hadiths = await HadithRepository.all();

    // h1.txt starts with two BOMs before the Arabic title.
    expect(hadiths.first.title.codeUnitAt(0), isNot(0xFEFF));
    expect(hadiths.first.title, 'الحد يث الأول');
    expect(hadiths.first.number, 1);
  });

  test('hadiths are numbered one to fifty and cached', () async {
    final first = await HadithRepository.all();
    final second = await HadithRepository.all();

    expect(identical(first, second), isTrue);
    expect(
      first.map((h) => h.number),
      List<int>.generate(HadithRepository.count, (i) => i + 1),
    );
  });

  testWidgets('the carousel renders hadith cards', (tester) async {
    await _pumpTab(tester);

    expect(find.byType(HadithCard), findsWidgets);
    expect(find.text('الحد يث الأول'), findsOneWidget);
  });

  testWidgets('tapping a card opens the hadith reader', (tester) async {
    final hadiths = await _warm(tester);
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      scaled(MaterialApp(
        theme: AppTheme.dark,
        home: HadithDetailsScreen(hadith: hadiths.first),
      )),
    );
    await tester.pump();

    expect(find.text(AppStrings.hadithNumber(1)), findsOneWidget);
    expect(find.text('الحد يث الأول'), findsOneWidget);
    expect(find.text(hadiths.first.body), findsOneWidget);
  });

  testWidgets('dragging the carousel advances to the next hadith',
      (tester) async {
    await _pumpTab(tester);

    expect(find.text('الحد يث الأول'), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(-320, 0));
    await tester.pumpAndSettle();

    // Hadith 2 is now centred. Hadith 1 stays on screen as the peeking
    // neighbour card, which is what the design shows, so the carousel keeps
    // rendering more than one card.
    expect(find.text('الحد يث الثاني'), findsOneWidget);
    expect(find.byType(HadithCard), findsWidgets);
  });

  testWidgets('the reader is reachable from the carousel', (tester) async {
    Hadith? selected;
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await _warm(tester);
    await tester.pumpWidget(
      scaled(MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          body: HadethTab(onHadithSelected: (h) => selected = h),
        ),
      )),
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.byType(HadithCard).first);
    await tester.pump();

    expect(selected, isNotNull);
    expect(selected!.number, 1);
  });
}
