import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_harness.dart';
import 'package:islami/core/app_strings.dart';
import 'package:islami/core/data/azkar_repository.dart';
import 'package:islami/core/data/prayer_times_service.dart';
import 'package:islami/core/models/azkar_category.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/modules/times/models/prayer_schedule.dart';
import 'package:islami/modules/times/widgets/azkar_card.dart';
import 'package:islami/modules/times/widgets/prayer_panel.dart';

PrayerSchedule _scheduleFor(DateTime day) => PrayerSchedule.forDay(
      PrayerTimesService.defaultCoordinates,
      day: day,
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(AzkarRepository.clearCache);

  test('the schedule lists the six prayers in order', () {
    final schedule = _scheduleFor(DateTime(2024, 7, 16));

    expect(
      schedule.entries.map((e) => e.label),
      <String>[
        AppStrings.fajr,
        AppStrings.sunrise,
        AppStrings.dhuhr,
        AppStrings.asr,
        AppStrings.maghrib,
        AppStrings.isha,
      ],
    );
    expect(
      schedule.entries.map((e) => e.prayer),
      <Prayer>[
        Prayer.fajr,
        Prayer.sunrise,
        Prayer.dhuhr,
        Prayer.asr,
        Prayer.maghrib,
        Prayer.isha,
      ],
    );
  });

  test('prayer times run forwards through the day', () {
    final entries = _scheduleFor(DateTime(2024, 7, 16)).entries;

    for (var i = 1; i < entries.length; i++) {
      expect(
        entries[i].time.isAfter(entries[i - 1].time),
        isTrue,
        reason: '${entries[i].label} should follow ${entries[i - 1].label}',
      );
    }
  });

  test('clock times are rendered in the requested zone', () {
    // Cairo, 23 Aug 2026, UTC+3 — independent of the machine's own zone.
    final schedule = PrayerSchedule.forDay(
      PrayerTimesService.defaultCoordinates,
      day: DateTime(2026, 8, 23),
      utcOffset: const Duration(hours: 3),
    );

    final clocks = <String, String>{
      for (final e in schedule.entries) e.label: '${e.clock} ${e.meridiem}',
    };

    expect(clocks[AppStrings.fajr], '04:55 AM');
    expect(clocks[AppStrings.sunrise], '06:27 AM');
    expect(clocks[AppStrings.dhuhr], '12:59 PM');
    expect(clocks[AppStrings.asr], '04:33 PM');
    expect(clocks[AppStrings.maghrib], '07:28 PM');
    expect(clocks[AppStrings.isha], '08:50 PM');
  });

  test('the header dates match the design formats', () {
    final schedule = _scheduleFor(DateTime(2024, 7, 16));

    // The design reads "16 Jul, 2024" / "Tuesday" / "09 Muh, 1446".
    expect(schedule.gregorian.replaceAll('\n', ' '), '16 Jul, 2024');
    expect(schedule.weekday, 'Tuesday');
    expect(schedule.hijri, matches(RegExp(r'^\d{2} \w+,\n\d{4}$')));
  });

  test('the countdown is always a positive HH:mm', () {
    final schedule = _scheduleFor(DateTime.now());

    expect(schedule.untilNextPrayer, matches(RegExp(r'^\d{2}:\d{2}$')));
  });

  test('after Isha the countdown rolls over to tomorrow instead of zero', () {
    // A day that is already finished: every prayer is in the past, so
    // `nextPrayer()` reports none.
    final finished = _scheduleFor(
      DateTime.now().subtract(const Duration(days: 2)),
    );

    expect(finished.times.nextPrayer(), Prayer.none);
    expect(finished.untilNextPrayer, isNot('00:00'));
    expect(finished.untilNextPrayer, matches(RegExp(r'^\d{2}:\d{2}$')));
  });

  test('every azkar category resolves to entries in the data set', () async {
    for (final category in AzkarCategory.values) {
      final azkar = await AzkarRepository.of(category);

      expect(azkar, isNotEmpty, reason: category.title);
      expect(azkar.every((z) => z.content.trim().isNotEmpty), isTrue);
      expect(azkar.every((z) => z.repeat >= 1), isTrue);
    }
  });

  testWidgets('the panel renders the schedule', (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final schedule = _scheduleFor(DateTime(2024, 7, 16));
    await tester.pumpWidget(
      scaled(MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(body: PrayerPanel(schedule: schedule)),
      )),
    );
    await tester.pump();

    expect(find.text(AppStrings.prayTime), findsOneWidget);
    expect(find.text('Tuesday'), findsOneWidget);
    expect(find.text(AppStrings.asr), findsOneWidget);
  });

  testWidgets('the azkar grid shows all four collections', (tester) async {
    tester.view.physicalSize = const Size(430, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    AzkarCategory? tapped;
    await tester.pumpWidget(
      scaled(MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          body: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 185 / 259,
            children: <Widget>[
              for (final category in AzkarCategory.values)
                AzkarCard(
                  category: category,
                  onTap: () => tapped = category,
                ),
            ],
          ),
        ),
      )),
    );
    await tester.pump();

    expect(find.text(AppStrings.azkarEvening), findsOneWidget);
    expect(find.text(AppStrings.azkarMorning), findsOneWidget);
    expect(find.text(AppStrings.azkarWaking), findsOneWidget);
    expect(find.text(AppStrings.azkarSleeping), findsOneWidget);

    await tester.tap(find.text(AppStrings.azkarMorning));
    expect(tapped, AzkarCategory.morning);
  });
}
