import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_assets.dart';
import '../../../core/models/hadith.dart';
import '../../../core/theme/app_theme.dart';

/// The watermark covers 428 of the card's 618pt height, at a quarter
/// strength. Both are ratios, so neither is scaled.
const double _kWatermarkHeightFactor = 428 / 618;
const double _kWatermarkOpacity = 0.25;

/// A gold tile carrying one hadith: filigree corners, a faint book
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
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: _kWatermarkHeightFactor,
                child: Opacity(
                  opacity: _kWatermarkOpacity,
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
              height: 89.h,
              child: Image.asset(
                AppAssets.cardMosqueBand,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 10.r,
              top: 10.r,
              child: const _CardCorner(mirrored: true),
            ),
            Positioned(
              right: 10.r,
              top: 10.r,
              child: const _CardCorner(),
            ),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 43.h,
                  bottom: 25.h,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      hadith.title,
                      textDirection: TextDirection.rtl,
                      style: AppTextStyles.hadithCardTitle,
                    ),
                    SizedBox(height: 25.h),
                    Expanded(
                      child: SizedBox(
                        width: 266.w,
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
      width: 93.r,
      height: 93.r,
    );
    if (!mirrored) return corner;
    return Transform.flip(flipX: true, child: corner);
  }
}
