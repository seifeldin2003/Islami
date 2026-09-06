import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_dimens.dart';
import '../../../core/app_durations.dart';
import '../../../core/design_scale.dart';
import '../../../core/theme/app_theme.dart';

/// Figma `Sebha` (node 62:9658): the fixed tassel head above a ring of
/// beads that turns one bead per tap, with the current phrase and count
/// inside the ring.
class SebhaBeads extends StatelessWidget {
  const SebhaBeads({
    super.key,
    required this.turns,
    required this.phrase,
    required this.count,
    required this.onTap,
  });

  /// Ring rotation in whole turns; one bead is 1/33 of a turn.
  final double turns;
  final String phrase;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: context.dx(AppDimens.sebhaGroupWidth),
        height: context.dy(AppDimens.sebhaGroupHeight),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: context.dx(AppDimens.sebhaHeadLeft),
              top: 0,
              width: context.dx(AppDimens.sebhaHeadWidth),
              height: context.dy(AppDimens.sebhaHeadHeight),
              child: Image.asset(
                AppAssets.sebhaHead,
                // The export is an alpha mask, so it carries no colour.
                color: AppColors.gold,
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            Positioned(
              left: 0,
              top: context.dy(AppDimens.sebhaBodyLocalTop),
              width: context.dx(AppDimens.sebhaBodySize),
              height: context.dx(AppDimens.sebhaBodySize),
              child: AnimatedRotation(
                turns: turns,
                duration: AppDurations.sebhaBead,
                curve: Curves.easeOut,
                child: SvgPicture.asset(AppAssets.sebhaBody),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: context.dy(AppDimens.sebhaBodyLocalTop),
              height: context.dx(AppDimens.sebhaBodySize),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      phrase,
                      textDirection: TextDirection.rtl,
                      style: AppTextStyles.sebha,
                    ),
                    const SizedBox(height: AppDimens.sebhaCounterGap),
                    Text('$count', style: AppTextStyles.sebha),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
