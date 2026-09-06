import 'package:flutter/widgets.dart';

import 'app_dimens.dart';

/// Maps coordinates authored on the Figma canvas onto the running device.
///
/// The splash screen is an absolutely positioned composition, so every
/// Figma `x`/`y`/`width` is passed through [dx]/[dy] instead of being
/// hard-coded for a single screen size.
extension DesignScale on BuildContext {
  /// Horizontal scale factor between the device and the design canvas.
  double get designScaleX =>
      MediaQuery.sizeOf(this).width / AppDimens.designWidth;

  /// Vertical scale factor between the device and the design canvas.
  double get designScaleY =>
      MediaQuery.sizeOf(this).height / AppDimens.designHeight;

  /// Converts a horizontal Figma value (x offset or width) to device pixels.
  double dx(double designValue) => designValue * designScaleX;

  /// Converts a vertical Figma value (y offset or height) to device pixels.
  double dy(double designValue) => designValue * designScaleY;
}
