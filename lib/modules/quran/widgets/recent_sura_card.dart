import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_dimens.dart';
import '../../../core/app_strings.dart';
import '../../../core/models/sura.dart';
import '../../../core/theme/app_theme.dart';

/// Figma `Recent Sura Card`: a gold tile carrying both sura names, the verse
/// count and the lantern artwork.
class RecentSuraCard extends StatelessWidget {
  const RecentSuraCard({super.key, required this.sura, required this.onTap});

  final Sura sura;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.recentCardRadius),
      child: Container(
        width: AppDimens.recentCardWidth,
        height: AppDimens.recentCardHeight,
        decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(AppDimens.recentCardRadius),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: AppDimens.recentCardArtInset,
              top: AppDimens.recentCardArtTop,
              width: AppDimens.recentCardArtWidth,
              height: AppDimens.recentCardArtHeight,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppDimens.recentCardRadius),
                child: Image.asset(AppAssets.suraCardArt, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              left: AppDimens.recentCardPadding,
              top: AppDimens.recentCardTopPadding,
              right: AppDimens.recentCardArtInset,
              bottom: AppDimens.recentCardBottomPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    sura.englishName,
                    style: AppTextStyles.recentCardName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    sura.arabicName,
                    style: AppTextStyles.recentCardName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    AppStrings.verses(sura.versesCount),
                    style: AppTextStyles.recentCardVerses,
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
