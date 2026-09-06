import 'package:adhan/adhan.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import '../../../core/app_strings.dart';
import '../../../core/data/prayer_times_service.dart';

/// One prayer as the Figma `Pray Time` tile presents it.
class PrayerEntry {
  const PrayerEntry({
    required this.prayer,
    required this.label,
    required this.time,
  });

  final Prayer prayer;
  final String label;
  final DateTime time;

  String get clock => DateFormat(AppStrings.clockPattern).format(time);
  String get meridiem => DateFormat(AppStrings.meridiemPattern).format(time);
}

/// View model behind the prayer-times panel.
class PrayerSchedule {
  const PrayerSchedule._({
    required this.coordinates,
    required this.day,
    required this.times,
    this.utcOffset,
  });

  /// The schedule at [coordinates] for [day] (defaults to today).
  factory PrayerSchedule.forDay(
    Coordinates coordinates, {
    DateTime? day,
    Duration? utcOffset,
  }) {
    final date = day ?? DateTime.now();
    return PrayerSchedule._(
      coordinates: coordinates,
      day: date,
      utcOffset: utcOffset,
      times: PrayerTimesService.scheduleFor(
        coordinates,
        day: date,
        utcOffset: utcOffset,
      ),
    );
  }

  final Coordinates coordinates;
  final PrayerTimes times;
  final DateTime day;

  /// Zone the clock times are rendered in; defaults to the device's.
  final Duration? utcOffset;

  static final DateFormat _gregorian = DateFormat(AppStrings.gregorianPattern);
  static final DateFormat _weekday = DateFormat(AppStrings.weekdayPattern);

  String get gregorian => _gregorian.format(day);
  String get weekday => _weekday.format(day);

  String get hijri {
    final date = HijriCalendar.fromDate(day);
    final month = date.getShortMonthName();
    return '${date.hDay.toString().padLeft(2, '0')} $month,\n${date.hYear}';
  }

  Prayer get current => times.currentPrayer();

  List<PrayerEntry> get entries => <PrayerEntry>[
        PrayerEntry(
          prayer: Prayer.fajr,
          label: AppStrings.fajr,
          time: times.fajr,
        ),
        PrayerEntry(
          prayer: Prayer.sunrise,
          label: AppStrings.sunrise,
          time: times.sunrise,
        ),
        PrayerEntry(
          prayer: Prayer.dhuhr,
          label: AppStrings.dhuhr,
          time: times.dhuhr,
        ),
        PrayerEntry(
          prayer: Prayer.asr,
          label: AppStrings.asr,
          time: times.asr,
        ),
        PrayerEntry(
          prayer: Prayer.maghrib,
          label: AppStrings.maghrib,
          time: times.maghrib,
        ),
        PrayerEntry(
          prayer: Prayer.isha,
          label: AppStrings.isha,
          time: times.isha,
        ),
      ];

  /// Time left until the next prayer, as `HH:mm`.
  ///
  /// After Isha there is no later prayer today, so the countdown rolls over
  /// to tomorrow's Fajr rather than sitting at `00:00`.
  String get untilNextPrayer {
    final now = DateTime.now();
    final next = times.timeForPrayer(times.nextPrayer());

    if (next != null) {
      final gap = next.difference(now);
      if (!gap.isNegative) return _formatGap(gap);
    }

    // Anchor the rollover on the clock, not on `day` — otherwise a stale
    // schedule would count down to a Fajr that has already passed.
    var fajr = PrayerTimesService.scheduleFor(
      coordinates,
      day: now,
      utcOffset: utcOffset,
    ).fajr;
    if (!fajr.isAfter(now)) {
      fajr = PrayerTimesService.scheduleFor(
        coordinates,
        day: now.add(const Duration(days: 1)),
        utcOffset: utcOffset,
      ).fajr;
    }
    return _formatGap(fajr.difference(now));
  }

  static String _formatGap(Duration gap) {
    final hours = gap.inHours.toString().padLeft(2, '0');
    final minutes = (gap.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}
