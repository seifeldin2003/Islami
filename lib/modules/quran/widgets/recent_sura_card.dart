import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_strings.dart';
import '../../../core/models/sura.dart';
import '../../../core/theme/app_theme.dart';

/// A gold tile carrying both sura names, the verse count and the lantern
/// artwork.
class RecentSuraCard extends StatelessWidget {
  const RecentSuraCard({super.key, required this.sura, required this.onTap});

  final Sura sura;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: 283.w,
        height: 150.h,
        decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 6.w,
              top: 7.h,
              width: 153.w,
              height: 136.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(AppAssets.suraCardArt, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              left: 17.w,
              top: 12.h,
              right: 6.w,
              bottom: 20.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Flexible so a cramped card shrinks the names rather
                  // than overflowing the tile.
                  Flexible(
                    child: Text(
                      sura.englishName,
                      style: AppTextStyles.recentCardName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      sura.arabicName,
                      style: AppTextStyles.recentCardName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      AppStrings.verses(sura.versesCount),
                      style: AppTextStyles.recentCardVerses,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
