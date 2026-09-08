import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_theme.dart';

/// A two-way switch where the selected half is a gold pill on a dark
/// track.
class SegmentControl extends StatelessWidget {
  const SegmentControl({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: AppColors.scrim,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: <Widget>[
          for (var index = 0; index < labels.length; index++)
            Expanded(
              child: GestureDetector(
                onTap: () => onSelected(index),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  alignment: Alignment.center,
                  decoration: index == selectedIndex
                      ? BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(
                            12.r,
                          ),
                        )
                      : null,
                  child: Text(
                    labels[index],
                    style: index == selectedIndex
                        ? AppTextStyles.segmentSelected
                        : AppTextStyles.segmentUnselected,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
