import 'package:flutter/material.dart';

import '../../../core/design_scale.dart';
import '../../../core/theme/app_theme.dart';

/// Figma `Background`: a photograph behind a scrim that fades from
/// `rgba(32,32,32,0.7)` into the flat app background.
///
/// The Qur'an and Hadeth destinations use different photographs and
/// different heights, so both are parameters.
class ScrimBackdrop extends StatelessWidget {
  const ScrimBackdrop({
    super.key,
    required this.image,
    required this.designHeight,
  });

  final String image;

  /// Height as authored on the Figma canvas.
  final double designHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      height: context.dy(designHeight),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[AppColors.scrim, AppColors.background],
            ),
          ),
          child: SizedBox.expand(),
        ),
      ),
    );
  }
}
