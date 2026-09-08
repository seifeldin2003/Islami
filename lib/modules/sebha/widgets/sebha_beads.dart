import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_durations.dart';
import '../../../core/theme/app_theme.dart';

/// A fixed tassel head above a ring of beads that turns one bead per tap,
/// with the current phrase and count inside the ring.
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
        width: 379.w,
        height: 460.h,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 182.w,
              top: 0,
              width: 73.w,
              height: 86.h,
              child: Image.asset(
                AppAssets.sebhaHead,
                // The export is an alpha mask, so it carries no colour.
                color: AppColors.gold,
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            Positioned(
              left: 0,
              top: 79.h,
              width: 379.w,
              height: 379.w,
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
              top: 79.h,
              height: 379.w,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      phrase,
                      textDirection: TextDirection.rtl,
                      style: AppTextStyles.sebha,
                    ),
                    SizedBox(height: 12.h),
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
