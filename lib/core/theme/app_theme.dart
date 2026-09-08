import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The app's colour tokens.
class AppColors {
  const AppColors._();

  /// App-wide dark surface.
  static const Color background = Color(0xFF202020);

  /// Primary gold, used for headings and body copy.
  static const Color gold = Color(0xFFE2BE7F);

  /// Deep gold at the top of the wordmark gradient.
  static const Color goldDeep = Color(0xFFC0A37C);

  /// Bright gold: the active progress pill and the foot of the wordmark
  /// gradient.
  static const Color goldLight = Color(0xFFFFD482);

  /// Muted gold, used by the splash credit line.
  static const Color goldMuted = Color(0xFFDAB98D);

  /// Inactive onboarding dot.
  static const Color dotInactive = Color(0xFF707070);

  /// Section headings and the search hint.
  static const Color offWhite = Color(0xFFFEFFE8);

  /// Search-field fill and the top of the backdrop scrim.
  static const Color scrim = Color(0xB3202020);

  /// Shoulders of the prayer-times panel.
  static const Color prayPanel = Color(0xFF856B3F);

  /// Gold at half strength: the mosque band at the foot of the readers.
  static const Color goldHalf = Color(0x80E2BE7F);

  /// Pill behind the selected bottom-navigation icon.
  static const Color navSelectedPill = Color(0x99202020);
}

/// Font families bundled under `assets/fonts`.
class AppFonts {
  const AppFonts._();

  /// Display face used by the "Islami" logo lockup.
  static const String kamali = 'Kamali';

  /// Primary UI face (headings, body, navigation).
  static const String jannaLt = 'JannaLT';

  /// Used only by the splash credit line.
  static const String poppins = 'Poppins';
}

/// The app's type scale.
///
/// Sizes are expressed with ScreenUtil's `.sp`, so they are getters
/// rather than constants — an extension call cannot be const.
class AppTextStyles {
  const AppTextStyles._();

  /// The `Islami` wordmark. Its colour comes from the gradient shader in
  /// `IslamiHeader`, so it is left white here.
  static TextStyle get wordmark => TextStyle(
        fontFamily: AppFonts.kamali,
        fontSize: 80.sp,
        color: Colors.white,
      );

  /// Intro slide headline.
  static TextStyle get title => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.gold,
      );

  /// Intro slide supporting copy.
  static TextStyle get body => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.gold,
      );

  /// Onboarding Back / Next / Finish.
  static TextStyle get button => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.gold,
      );

  /// Home section heading and search hint.
  static TextStyle get sectionTitle => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.offWhite,
      );

  /// Sura name in the list.
  static TextStyle get suraName => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  /// Verse count in the list.
  static TextStyle get suraVerses => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  /// Sura name on a "Most Recently" card.
  static TextStyle get recentCardName => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.background,
      );

  /// Verse count on a "Most Recently" card.
  static TextStyle get recentCardVerses => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.background,
      );

  /// Selected bottom-navigation label.
  static TextStyle get navLabel => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  /// Detail-screen app bar title.
  static TextStyle get detailTitle => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.gold,
      );

  /// Arabic heading under the corner ornaments.
  static TextStyle get detailHeading => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.gold,
      );

  /// A verse inside its card.
  static TextStyle get verse => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.gold,
        height: 2.5,
      );

  /// Hadith title on a carousel card.
  static TextStyle get hadithCardTitle => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.background,
      );

  /// Hadith body on a carousel card.
  static TextStyle get hadithCardBody => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.background,
      );

  /// Hadith body on the detail screen.
  static TextStyle get hadithBody => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.gold,
        height: 2,
      );

  /// Sebha verse, tasbeeh phrase and counter.
  static TextStyle get sebha => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 36.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  /// Radio station name.
  static TextStyle get radioStation => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.background,
      );

  /// Selected segment label.
  static TextStyle get segmentSelected => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.background,
      );

  /// Unselected segment label.
  static TextStyle get segmentUnselected => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  /// "Pray Time" heading.
  static TextStyle get prayHeading => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.background,
      );

  /// Weekday under the heading.
  static TextStyle get prayWeekday => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.background,
      );

  /// Gregorian / hijri date in the shoulder pills.
  static TextStyle get prayDate => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.gold,
      );

  /// Prayer name on a tile.
  static TextStyle get prayerName => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  /// Prayer clock time.
  static TextStyle get prayerTime => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  /// AM / PM under the clock.
  static TextStyle get prayerMeridiem => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  /// "Next Pray - 02:32".
  static TextStyle get nextPray => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.background,
      );

  /// Azkar card title.
  static TextStyle get azkarCardTitle => TextStyle(
        fontFamily: AppFonts.jannaLt,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  /// Splash credit line.
  static TextStyle get splashCredit => TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 16.sp,
        color: AppColors.goldMuted,
      );
}

/// The single [ThemeData] the app runs on.
class AppTheme {
  const AppTheme._();

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: AppFonts.jannaLt,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.gold,
          surface: AppColors.background,
        ),
      );
}
