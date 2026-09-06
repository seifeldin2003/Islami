import 'package:flutter/material.dart';

import '../../../core/app_dimens.dart';
import '../../../core/models/azkar_category.dart';
import '../../../core/theme/app_theme.dart';

/// Figma `Group 15` (node 123:84): an outlined tile for one azkar
/// collection.
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
            width: AppDimens.azkarCardBorder,
          ),
          borderRadius: BorderRadius.circular(AppDimens.azkarCardRadius),
        ),
        child: Column(
          children: <Widget>[
            Expanded(child: Image.asset(category.icon, fit: BoxFit.contain)),
            Text(
              category.title,
              textAlign: TextAlign.center,
              style: AppTextStyles.azkarCardTitle,
            ),
            const SizedBox(height: AppDimens.azkarCardTitleGap),
          ],
        ),
      ),
    );
  }
}
