import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_dimens.dart';
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

/// Figma `Time Screen` (node 104:18): today's prayer schedule above the
/// azkar collections.
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
        const ScrimBackdrop(
          image: AppAssets.timesBackground,
          designHeight: AppDimens.timesBackdropHeight,
        ),
        SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.homeGutter,
            ),
            children: <Widget>[
              const Center(child: IslamiHeader()),
              const SizedBox(height: AppDimens.azkarSectionGap),
              FutureBuilder<Coordinates>(
                future: _coordinates,
                builder: (context, snapshot) {
                  final coordinates = snapshot.data;
                  if (coordinates == null) {
                    return const SizedBox(
                      height: AppDimens.prayPanelHeight,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return PrayerPanel(
                    schedule: PrayerSchedule.forDay(coordinates),
                  );
                },
              ),
              const SizedBox(height: AppDimens.azkarSectionGap),
              const Text(
                AppStrings.azkarSection,
                style: AppTextStyles.sectionTitle,
              ),
              const SizedBox(height: AppDimens.azkarSectionGap),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: AppDimens.azkarCardGap,
                crossAxisSpacing: AppDimens.azkarCardGap,
                childAspectRatio: AppDimens.azkarCardAspectRatio,
                children: <Widget>[
                  for (final category in AzkarCategory.values)
                    AzkarCard(
                      category: category,
                      onTap: () => widget.onAzkarSelected(category),
                    ),
                ],
              ),
              const SizedBox(height: AppDimens.azkarSectionGap),
            ],
          ),
        ),
      ],
    );
  }
}
