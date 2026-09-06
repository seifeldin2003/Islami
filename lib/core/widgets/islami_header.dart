import 'package:flutter/material.dart';

import '../app_assets.dart';
import '../app_dimens.dart';
import '../app_strings.dart';
import '../theme/app_theme.dart';

/// The `Islami` lockup: the mosque silhouette with the Kamali wordmark laid
/// over it, exactly as the Figma `img_header` / `Logo` frames compose it.
///
/// It is built from the transparent silhouette plus live text rather than a
/// flattened bitmap, so it sits correctly on the home screen's photographic
/// backdrop as well as on a flat background.
class IslamiHeader extends StatelessWidget {
  const IslamiHeader({super.key, this.width = AppDimens.headerWidth});

  final double width;

  /// Top-to-bottom gold gradient the Figma wordmark is filled with.
  static Shader _wordmarkShader(double fontSize) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[AppColors.goldDeep, AppColors.goldLight],
      ).createShader(Rect.fromLTWH(0, 0, 0, fontSize));

  @override
  Widget build(BuildContext context) {
    final scale = width / AppDimens.headerWidth;
    final fontSize = AppTextStyles.wordmark.fontSize! * scale;

    return SizedBox(
      width: width,
      height: AppDimens.headerHeight * scale,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            width: width,
            height: AppDimens.headerMosqueHeight * scale,
            child: Image.asset(AppAssets.mosqueSilhouette, fit: BoxFit.fill),
          ),
          Positioned(
            left: AppDimens.headerWordmarkLeft * scale,
            top: AppDimens.headerWordmarkTop * scale,
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
