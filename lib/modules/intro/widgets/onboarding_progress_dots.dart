import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_theme.dart';

/// Four dots plus a wider pill for the active step.
class OnboardingProgressDots extends StatelessWidget {
  const OnboardingProgressDots({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return Container(
          margin: EdgeInsets.only(
            right: index == count - 1 ? 0 : 11.r,
          ),
          width: isActive ? 18.r : 7.r,
          height: 7.r,
          decoration: BoxDecoration(
            color: isActive ? AppColors.goldLight : AppColors.dotInactive,
            borderRadius: BorderRadius.circular(3.5.r),
          ),
        );
      }),
    );
  }
}
