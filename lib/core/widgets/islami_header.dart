import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_assets.dart';
import '../app_strings.dart';
import '../theme/app_theme.dart';

/// The `Islami` lockup: the mosque silhouette with the Kamali wordmark laid
/// over it.
///
/// It is built from the transparent silhouette plus live text rather than a
/// flattened bitmap, so it sits correctly on the home screen's photographic
/// backdrop as well as on a flat background.
class IslamiHeader extends StatelessWidget {
  const IslamiHeader({super.key, this.width});

  /// Rendered width; defaults to the artboard's 291pt lockup.
  final double? width;

  /// Top-to-bottom gold gradient the wordmark is filled with.
  static Shader _wordmarkShader(double fontSize) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[AppColors.goldDeep, AppColors.goldLight],
      ).createShader(Rect.fromLTWH(0, 0, 0, fontSize));

  @override
  Widget build(BuildContext context) {
    // `.r` (the smaller of the width and height ratios) rather than `.w`:
    // the lockup is artwork, so it has to scale uniformly instead of
    // stretching to fill a wide viewport.
    final width = this.width ?? 291.r;
    final scale = width / 291;
    final fontSize = AppTextStyles.wordmark.fontSize! * scale;

    return SizedBox(
      width: width,
      height: 171.h * scale,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            width: width,
            height: 151.h * scale,
            child: Image.asset(AppAssets.mosqueSilhouette, fit: BoxFit.fill),
          ),
          Positioned(
            left: 63.w * scale,
            top: 75.h * scale,
            child: Text(
              AppStrings.appTitle,
              style: AppTextStyles.wordmark.copyWith(
                fontSize: fontSize,
                // Painting the glyphs with the shader keeps the gradient
                // inside the letterforms; a ShaderMask layer leaves a light
                // fringe where a glyph overruns its layout box.
                foreground: Paint()..shader = _wordmarkShader(fontSize),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
