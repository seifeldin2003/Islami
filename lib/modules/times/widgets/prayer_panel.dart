import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../models/prayer_schedule.dart';

/// The day's prayer schedule.
class PrayerPanel extends StatelessWidget {
  const PrayerPanel({super.key, required this.schedule});

  final PrayerSchedule schedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 301.h,
      decoration: BoxDecoration(
        color: AppColors.prayPanel,
        borderRadius: BorderRadius.circular(20.r * 2),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 76.h,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      schedule.gregorian,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.prayDate,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppStrings.prayTime,
                      style: AppTextStyles.prayHeading,
                    ),
                    Text(schedule.weekday, style: AppTextStyles.prayWeekday),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      schedule.hijri,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.prayDate,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(
                  20.r * 2,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(child: _Tiles(schedule: schedule)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppStrings.nextPray(schedule.untilNextPrayer),
                        style: AppTextStyles.nextPray,
                      ),
                      SizedBox(width: 12.w),
                      const Icon(
                        Icons.volume_up,
                        color: AppColors.background,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.w),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tiles extends StatelessWidget {
  const _Tiles({required this.schedule});

  final PrayerSchedule schedule;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      itemCount: schedule.entries.length,
      separatorBuilder: (_, __) => SizedBox(width: 8.w),
      itemBuilder: (context, index) {
        final entry = schedule.entries[index];
        return Center(
          child:
              _Tile(entry: entry, isCurrent: entry.prayer == schedule.current),
        );
      },
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.entry, required this.isCurrent});

  final PrayerEntry entry;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isCurrent ? 104.w : 86.w,
      height: isCurrent ? 128.h : 106.h,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(entry.label, style: AppTextStyles.prayerName),
          FittedBox(
            child: Text(entry.clock, style: AppTextStyles.prayerTime),
          ),
          Text(entry.meridiem, style: AppTextStyles.prayerMeridiem),
        ],
      ),
    );
  }
}
