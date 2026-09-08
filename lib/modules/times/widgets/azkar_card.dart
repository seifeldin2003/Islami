import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/models/azkar_category.dart';
import '../../../core/theme/app_theme.dart';

/// An outlined tile for one azkar collection.
class AzkarCard extends StatelessWidget {
  const AzkarCard({super.key, required this.category, required this.onTap});

  final AzkarCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(
            color: AppColors.gold,
            width: 2.r,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          children: <Widget>[
            Expanded(child: Image.asset(category.icon, fit: BoxFit.contain)),
            Text(
              category.title,
              textAlign: TextAlign.center,
              style: AppTextStyles.azkarCardTitle,
            ),
            SizedBox(height: 6.h),
          ],
        ),
      ),
    );
  }
}
