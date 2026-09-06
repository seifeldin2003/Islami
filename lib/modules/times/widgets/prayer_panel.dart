import 'package:flutter/material.dart';

import '../../../core/app_dimens.dart';
import '../../../core/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../models/prayer_schedule.dart';

/// Figma `Rectangle 138` (node 104:245): the day's prayer schedule.
class PrayerPanel extends StatelessWidget {
  const PrayerPanel({super.key, required this.schedule});

  final PrayerSchedule schedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.prayPanelHeight,
      decoration: BoxDecoration(
        color: AppColors.prayPanel,
        borderRadius: BorderRadius.circular(AppDimens.prayPanelRadius * 2),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: AppDimens.prayHeaderHeight,
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
                    const Text(
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
                  AppDimens.prayPanelRadius * 2,
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
                      const SizedBox(width: AppDimens.prayNextGap),
                      const Icon(
                        Icons.volume_up,
                        color: AppColors.background,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimens.prayNextGap),
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
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.prayTileGap),
      itemCount: schedule.entries.length,
      separatorBuilder: (_, __) =>
          const SizedBox(width: AppDimens.prayTileGap),
      itemBuilder: (context, index) {
        final entry = schedule.entries[index];
        return Center(
          child: _Tile(entry: entry, isCurrent: entry.prayer == schedule.current),
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
      width: isCurrent
          ? AppDimens.prayTileActiveWidth
          : AppDimens.prayTileWidth,
      height: isCurrent
          ? AppDimens.prayTileActiveHeight
          : AppDimens.prayTileHeight,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimens.prayTileRadius),
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
