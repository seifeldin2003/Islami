import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_durations.dart';
import '../../../core/app_routes.dart';
import '../../../core/app_strings.dart';
import '../../../core/theme/app_theme.dart';

/// Absolute coordinates of the splash composition, on the 430 x 932
/// design canvas.
class _Layout {
  const _Layout._();

  static const double skylineTop = 57;
  static const double skylineWidth = 291;

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
  static const double creditRightInset = 430 - 337;
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
            top: _Layout.skylineTop.h,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                AppAssets.mosqueSilhouette,
                width: _Layout.skylineWidth.w,
              ),
            ),
          ),
          Positioned(
            left: _Layout.lanternLeft.w,
            top: _Layout.lanternTop.h,
            width: _Layout.lanternWidth.w,
            child: Image.asset(AppAssets.splashLantern),
          ),
          Positioned(
            left: 0,
            top: _Layout.ornamentLeftTop.h,
            width: _Layout.ornamentLeftWidth.w,
            child: Image.asset(AppAssets.splashOrnamentLeft),
          ),
          Positioned(
            left: _Layout.ornamentRightLeft.w,
            top: _Layout.ornamentRightTop.h,
            width: _Layout.ornamentRightWidth.w,
            child: Image.asset(AppAssets.splashOrnamentRight),
          ),
          Positioned(
            left: _Layout.logoLeft.w,
            top: _Layout.logoTop.h,
            width: _Layout.logoWidth.w,
            child: Image.asset(AppAssets.splashLogo),
          ),
          Positioned(
            left: _Layout.routeLogoLeft.w,
            top: _Layout.routeLogoTop.h,
            width: _Layout.routeLogoWidth.w,
            height: _Layout.routeLogoHeight.h,
            child: Image.asset(AppAssets.routeLogo, fit: BoxFit.cover),
          ),
          Positioned(
            top: _Layout.creditTop.h,
            right: _Layout.creditRightInset.w,
            child: Text(
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
