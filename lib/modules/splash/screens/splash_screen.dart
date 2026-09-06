import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_dimens.dart';
import '../../../core/app_durations.dart';
import '../../../core/app_routes.dart';
import '../../../core/app_strings.dart';
import '../../../core/design_scale.dart';
import '../../../core/theme/app_theme.dart';

/// Absolute coordinates of the Figma `Splash Screen` frame (node 9:20),
/// expressed on the 430 x 932 design canvas.
class _Layout {
  const _Layout._();

  static const double skylineTop = 57;
  static const double skylineWidth = AppDimens.headerWidth;

  static const double lanternLeft = 329;
  static const double lanternTop = 0;
  static const double lanternWidth = 88;

  static const double ornamentLeftTop = 214;
  static const double ornamentLeftWidth = 87;

  static const double ornamentRightLeft = 329;
  static const double ornamentRightTop = 604;
  static const double ornamentRightWidth = 101;

  static const double logoLeft = 127;
  static const double logoTop = 341;
  static const double logoWidth = 174;

  static const double routeLogoLeft = 125;
  static const double routeLogoTop = 792;
  static const double routeLogoWidth = 180;
  static const double routeLogoHeight = 76;

  static const double creditTop = 862;

  /// The credit line is right-aligned; its right edge sits at x=337 on the
  /// 430pt canvas, so it is anchored by inset rather than by width (the
  /// font is not scaled with the canvas, so a fixed box would wrap).
  static const double creditRightInset = AppDimens.designWidth - 337;
}

/// Branded launch screen; hands over to the intro flow after
/// [AppDurations.splash].
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(AppDurations.splash, _goToIntro);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _goToIntro() {
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRoutes.intro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAssets.splashBackground, fit: BoxFit.cover),
          ),
          Positioned(
            top: context.dy(_Layout.skylineTop),
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                AppAssets.mosqueSilhouette,
                width: context.dx(_Layout.skylineWidth),
              ),
            ),
          ),
          Positioned(
            left: context.dx(_Layout.lanternLeft),
            top: context.dy(_Layout.lanternTop),
            width: context.dx(_Layout.lanternWidth),
            child: Image.asset(AppAssets.splashLantern),
          ),
          Positioned(
            left: 0,
            top: context.dy(_Layout.ornamentLeftTop),
            width: context.dx(_Layout.ornamentLeftWidth),
            child: Image.asset(AppAssets.splashOrnamentLeft),
          ),
          Positioned(
            left: context.dx(_Layout.ornamentRightLeft),
            top: context.dy(_Layout.ornamentRightTop),
            width: context.dx(_Layout.ornamentRightWidth),
            child: Image.asset(AppAssets.splashOrnamentRight),
          ),
          Positioned(
            left: context.dx(_Layout.logoLeft),
            top: context.dy(_Layout.logoTop),
            width: context.dx(_Layout.logoWidth),
            child: Image.asset(AppAssets.splashLogo),
          ),
          Positioned(
            left: context.dx(_Layout.routeLogoLeft),
            top: context.dy(_Layout.routeLogoTop),
            width: context.dx(_Layout.routeLogoWidth),
            height: context.dy(_Layout.routeLogoHeight),
            child: Image.asset(AppAssets.routeLogo, fit: BoxFit.cover),
          ),
          Positioned(
            top: context.dy(_Layout.creditTop),
            right: context.dx(_Layout.creditRightInset),
            child: const Text(
              AppStrings.supervisedBy,
              maxLines: 1,
              textAlign: TextAlign.right,
              style: AppTextStyles.splashCredit,
            ),
          ),
        ],
      ),
    );
  }
}
