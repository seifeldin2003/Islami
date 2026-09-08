import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_harness.dart';
import 'package:islami/core/app_strings.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/modules/sebha/screens/sebha_tab.dart';

Future<SebhaTabState> _pumpSebha(WidgetTester tester) async {
  tester.view.physicalSize = const Size(430, 932);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    scaled(MaterialApp(
        theme: AppTheme.dark, home: const Scaffold(body: SebhaTab()))),
  );
  await tester.pump();
  return tester.state<SebhaTabState>(find.byType(SebhaTab));
}

void main() {
  testWidgets('the counter starts at zero on the first phrase', (tester) async {
    final state = await _pumpSebha(tester);

    expect(state.count, 0);
    expect(state.phrase, AppStrings.tasbeehPhrases.first);
    expect(find.text(AppStrings.sebhaVerse), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('each tally advances the count', (tester) async {
    final state = await _pumpSebha(tester);

    for (var i = 0; i < 5; i++) {
      state.tally();
    }
    await tester.pump();

    expect(state.count, 5);
    expect(find.text('5'), findsOneWidget);
    expect(state.phrase, AppStrings.tasbeehPhrases.first);
  });

  testWidgets('the phrase changes after a full round', (tester) async {
    final state = await _pumpSebha(tester);

    for (var i = 0; i < SebhaTab.tasbeehTarget; i++) {
      state.tally();
    }
    await tester.pump();

    // The round finishes on the target, still on the first phrase.
    expect(state.count, SebhaTab.tasbeehTarget);
    expect(state.phrase, AppStrings.tasbeehPhrases.first);

    // The next tally starts the following phrase over again.
    state.tally();
    await tester.pump();

    expect(state.count, 1);
    expect(state.phrase, AppStrings.tasbeehPhrases[1]);
  });

  testWidgets('the phrases cycle back to the beginning', (tester) async {
    final state = await _pumpSebha(tester);

    final taps = SebhaTab.tasbeehTarget * AppStrings.tasbeehPhrases.length + 1;
    for (var i = 0; i < taps; i++) {
      state.tally();
    }
    await tester.pump();

    expect(state.phrase, AppStrings.tasbeehPhrases.first);
  });
}
