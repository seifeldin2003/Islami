import 'package:flutter/material.dart';

/// Colour tokens sampled from the Figma file.
class AppColors {
  const AppColors._();

  /// App-wide dark surface (`#202020`).
  static const Color background = Color(0xFF202020);

  /// Primary gold used for headings and body copy (`#E2BE7F`).
  static const Color gold = Color(0xFFE2BE7F);

  /// Deep gold at the top of the `Islami` wordmark gradient (`#C0A37C`).
  static const Color goldDeep = Color(0xFFC0A37C);

  /// Bright gold: active progress pill and the foot of the wordmark
  /// gradient (`#FFD482`).
  static const Color goldLight = Color(0xFFFFD482);

  /// Muted gold used by the splash credit line (`#DAB98D`).
  static const Color goldMuted = Color(0xFFDAB98D);

  /// Inactive onboarding dot (`#707070`).
  static const Color dotInactive = Color(0xFF707070);

  /// Section headings and search hint (`#FEFFE8`).
  static const Color offWhite = Color(0xFFFEFFE8);

  /// Search-field fill and the top of the home backdrop scrim
  /// (`rgba(32,32,32,0.7)`).
  static const Color scrim = Color(0xB3202020);

  /// Shoulders of the prayer-times panel (`#856B3F`).
  static const Color prayPanel = Color(0xFF856B3F);

  /// Gold at half strength; the mosque band at the foot of the detail
  /// screens (`rgba(226,190,127,0.5)`).
  static const Color goldHalf = Color(0x80E2BE7F);

  /// Pill behind the selected bottom-navigation icon
  /// (`rgba(32,32,32,0.6)`).
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

/// Text tokens sampled from the Figma file.
class AppTextStyles {
  const AppTextStyles._();

  /// The `Islami` wordmark — Kamali 80. The colour is supplied by the
  /// gradient shader in `IslamiHeader`, so it is left white here.
  static const TextStyle wordmark = TextStyle(
    fontFamily: AppFonts.kamali,
    fontSize: 80,
    color: Colors.white,
  );

  /// Intro slide headline — Janna LT Bold 24 / `#E2BE7F`.
  static const TextStyle title = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.gold,
  );

  /// Intro slide supporting copy — Janna LT Bold 20 / `#E2BE7F`.
  static const TextStyle body = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.gold,
  );

  /// Onboarding Back / Next / Finish — Janna LT Bold 16 / `#E2BE7F`.
  static const TextStyle button = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.gold,
  );

  /// Home section heading and search hint — Janna LT Bold 16 / `#FEFFE8`.
  static const TextStyle sectionTitle = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.offWhite,
  );

  /// Sura name in the list — Janna LT Bold 20 / white.
  static const TextStyle suraName = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// Verse count in the list — Janna LT Bold 14 / white.
  static const TextStyle suraVerses = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// Sura name on a "Most Recently" card — Janna LT Bold 24 / `#202020`.
  static const TextStyle recentCardName = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.background,
  );

  /// Verse count on a "Most Recently" card — Janna LT Bold 14 / `#202020`.
  static const TextStyle recentCardVerses = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.background,
  );

  /// Selected bottom-navigation label — Janna LT Bold 12 / white.
  static const TextStyle navLabel = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// Detail-screen app bar title — Janna LT Bold 20 / `#E2BE7F`.
  static const TextStyle detailTitle = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.gold,
  );

  /// Arabic heading under the corner ornaments — Janna LT Bold 24.
  static const TextStyle detailHeading = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.gold,
  );

  /// A verse inside its card — Janna LT Bold 20, line height 2.5.
  static const TextStyle verse = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.gold,
    height: 2.5,
  );

  /// Hadith title on a carousel card — Janna LT Bold 24 / `#202020`.
  static const TextStyle hadithCardTitle = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.background,
  );

  /// Hadith body on a carousel card — Janna LT Bold 16 / `#202020`.
  static const TextStyle hadithCardBody = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.background,
  );

  /// Hadith body on the detail screen — Janna LT Bold 20, line height 2.
  static const TextStyle hadithBody = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.gold,
    height: 2,
  );

  /// Sebha verse, tasbeeh phrase and counter — Janna LT Bold 36 / white.
  static const TextStyle sebha = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// Radio station name — Janna LT Bold 20 / `#202020`.
  static const TextStyle radioStation = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.background,
  );

  /// Selected segment label — Janna LT Bold 16 / `#202020`.
  static const TextStyle segmentSelected = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.background,
  );

  /// Unselected segment label — Janna LT Bold 16 / white.
  static const TextStyle segmentUnselected = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// "Pray Time" heading — Janna LT Bold 24 / `#202020`.
  static const TextStyle prayHeading = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.background,
  );

  /// Weekday under the heading — Janna LT Bold 20 / `#202020`.
  static const TextStyle prayWeekday = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.background,
  );

  /// Gregorian / hijri date in the shoulder pills — Janna LT Bold 16.
  static const TextStyle prayDate = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.gold,
  );

  /// Prayer name on a tile — Janna LT Bold 16 / white.
  static const TextStyle prayerName = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// Prayer clock time — Janna LT Bold 32 / white.
  static const TextStyle prayerTime = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// AM / PM under the clock — Janna LT Bold 16 / white.
  static const TextStyle prayerMeridiem = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// "Next Pray - 02:32" — Janna LT Bold 16 / `#202020`.
  static const TextStyle nextPray = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.background,
  );

  /// Azkar card title — Janna LT Bold 20 / white.
  static const TextStyle azkarCardTitle = TextStyle(
    fontFamily: AppFonts.jannaLt,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// Splash credit line — Poppins Regular 16 / `#DAB98D`.
  static const TextStyle splashCredit = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 16,
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
