import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_durations.dart';
import '../../../core/app_strings.dart';
import '../../../core/data/prayer_times_service.dart';
import '../../../core/models/azkar_category.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/islami_header.dart';
import '../../home/widgets/scrim_backdrop.dart';
import '../models/prayer_schedule.dart';
import '../widgets/azkar_card.dart';
import '../widgets/prayer_panel.dart';

/// Azkar tiles are 185 x 259 on the artboard; the ratio drives the grid.
const double _kAzkarAspectRatio = 185 / 259;

/// Today's prayer schedule above the azkar collections.
class TimesTab extends StatefulWidget {
  const TimesTab({super.key, required this.onAzkarSelected});

  final ValueChanged<AzkarCategory> onAzkarSelected;

  @override
  State<TimesTab> createState() => _TimesTabState();
}

class _TimesTabState extends State<TimesTab> {
  late final Future<Coordinates> _coordinates =
      PrayerTimesService.resolveCoordinates();

  /// Repaints so "Next Pray" counts down instead of freezing on the value
  /// it happened to have when the tab was first opened.
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(AppDurations.prayerTick, (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ScrimBackdrop(
          image: AppAssets.timesBackground,
          designHeight: 852.h,
        ),
        SafeArea(
          bottom: false,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            children: <Widget>[
              const Center(child: IslamiHeader()),
              SizedBox(height: 20.h),
              FutureBuilder<Coordinates>(
                future: _coordinates,
                builder: (context, snapshot) {
                  final coordinates = snapshot.data;
                  if (coordinates == null) {
                    return SizedBox(
                      height: 301.h,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                  return PrayerPanel(
                    schedule: PrayerSchedule.forDay(coordinates),
                  );
                },
              ),
              SizedBox(height: 20.h),
              Text(
                AppStrings.azkarSection,
                style: AppTextStyles.sectionTitle,
              ),
              SizedBox(height: 20.h),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 20.r,
                crossAxisSpacing: 20.r,
                childAspectRatio: _kAzkarAspectRatio,
                children: <Widget>[
                  for (final category in AzkarCategory.values)
                    AzkarCard(
                      category: category,
                      onTap: () => widget.onAzkarSelected(category),
                    ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ],
    );
  }
}
