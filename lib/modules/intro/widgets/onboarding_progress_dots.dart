import 'package:flutter/material.dart';

import '../../../core/app_dimens.dart';
import '../../../core/theme/app_theme.dart';

/// Figma `Progress` (90 x 7): four 7px dots plus an 18px pill for the
/// active step, separated by 11px gaps.
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
            right: index == count - 1 ? 0 : AppDimens.progressDotGap,
          ),
          width: isActive
              ? AppDimens.progressDotActiveWidth
              : AppDimens.progressDotSize,
          height: AppDimens.progressDotSize,
          decoration: BoxDecoration(
            color: isActive ? AppColors.goldLight : AppColors.dotInactive,
            borderRadius: BorderRadius.circular(AppDimens.progressDotRadius),
          ),
        );
      }),
    );
  }
}
