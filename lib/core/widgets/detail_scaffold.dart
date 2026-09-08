import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_assets.dart';
import '../app_strings.dart';
import '../theme/app_theme.dart';

/// The chrome shared by the reader screens: a transparent app bar, two
/// gold filigree corners around an Arabic heading, and the mosque band
/// along the bottom.
///
/// Both the sura reader and the hadith reader are built on it.
class DetailScaffold extends StatelessWidget {
  const DetailScaffold({
    super.key,
    required this.title,
    required this.heading,
    required this.child,
  });

  /// Latin title shown in the app bar.
  final String title;

  /// Arabic heading shown between the corner ornaments.
  final String heading;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 112.h,
            child: Image.asset(
              AppAssets.detailBottomDecoration,
              fit: BoxFit.cover,
              color: AppColors.goldHalf,
              colorBlendMode: BlendMode.srcIn,
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                _DetailAppBar(title: title),
                _HeadingBand(heading: heading),
                SizedBox(height: 33.h),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailAppBar extends StatelessWidget {
  const _DetailAppBar({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Positioned(
            left: 32.w,
            child: Semantics(
              button: true,
              label: AppStrings.back,
              child: GestureDetector(
                onTap: () => Navigator.of(context).maybePop(),
                behavior: HitTestBehavior.opaque,
                child: Transform.rotate(
                  angle: pi,
                  child: SvgPicture.asset(
                    AppAssets.icBackArrow,
                    width: 18.w,
                  ),
                ),
              ),
            ),
          ),
          Center(child: Text(title, style: AppTextStyles.detailTitle)),
        ],
      ),
    );
  }
}

/// The Arabic heading flanked by the two mirrored corner ornaments.
class _HeadingBand extends StatelessWidget {
  const _HeadingBand({required this.heading});

  final String heading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92.h,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 18.w,
            top: 0,
            child: const _CornerOrnament(mirrored: true),
          ),
          Positioned(
            right: 20.w,
            top: 0,
            child: const _CornerOrnament(),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 24.h,
            child: Text(
              heading,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: AppTextStyles.detailHeading,
            ),
          ),
        ],
      ),
    );
  }
}

class _CornerOrnament extends StatelessWidget {
  const _CornerOrnament({this.mirrored = false});

  final bool mirrored;

  @override
  Widget build(BuildContext context) {
    final ornament = Image.asset(
      AppAssets.detailCorner,
      width: 93.w,
      height: 92.h,
      color: AppColors.gold,
      colorBlendMode: BlendMode.srcIn,
    );

    if (!mirrored) return ornament;
    return Transform.flip(flipX: true, child: ornament);
  }
}
