import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_dimens.dart';
import '../../../core/models/hadith.dart';
import '../../../core/theme/app_theme.dart';

/// Figma `Hadith Card`: a gold tile with filigree corners, a faint book
/// watermark and a mosque band along its foot.
class HadithCard extends StatelessWidget {
  const HadithCard({super.key, required this.hadith, required this.onTap});

  final Hadith hadith;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(AppDimens.hadithCardRadius),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: AppDimens.hadithCardWatermarkHeightFactor,
                child: Opacity(
                  opacity: AppDimens.hadithCardWatermarkOpacity,
                  child: Image.asset(
                    AppAssets.hadithCardWatermark,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: AppDimens.hadithCardMosqueHeight,
              child: Image.asset(
                AppAssets.cardMosqueBand,
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              left: AppDimens.hadithCardCornerInset,
              top: AppDimens.hadithCardCornerInset,
              child: _CardCorner(mirrored: true),
            ),
            const Positioned(
              right: AppDimens.hadithCardCornerInset,
              top: AppDimens.hadithCardCornerInset,
              child: _CardCorner(),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppDimens.hadithCardTitleTop,
                  bottom: AppDimens.hadithCardPadding,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      hadith.title,
                      textDirection: TextDirection.rtl,
                      style: AppTextStyles.hadithCardTitle,
                    ),
                    const SizedBox(height: AppDimens.hadithCardTitleGap),
                    Expanded(
                      child: SizedBox(
                        width: AppDimens.hadithCardBodyWidth,
                        // Many hadiths are far longer than the card, so the
                        // body scrolls in place; the carousel still pages
                        // horizontally around it.
                        child: SingleChildScrollView(
                          child: Text(
                            hadith.body,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: AppTextStyles.hadithCardBody,
                          ),
                        ),
                      ),
                    ),
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

class _CardCorner extends StatelessWidget {
  const _CardCorner({this.mirrored = false});

  final bool mirrored;

  @override
  Widget build(BuildContext context) {
    final corner = Image.asset(
      AppAssets.hadithCardCorner,
      width: AppDimens.hadithCardCornerSize,
      height: AppDimens.hadithCardCornerSize,
    );
    if (!mirrored) return corner;
    return Transform.flip(flipX: true, child: corner);
  }
}
