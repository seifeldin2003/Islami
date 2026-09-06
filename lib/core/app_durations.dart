/// Animation and delay tokens shared across the app.
class AppDurations {
  const AppDurations._();

  /// How long the splash screen stays up before handing over to the intro.
  static const Duration splash = Duration(seconds: 3);

  /// How often the prayer-times countdown repaints.
  static const Duration prayerTick = Duration(seconds: 30);

  /// One bead of travel on the sebha ring.
  static const Duration sebhaBead = Duration(milliseconds: 200);

  /// Slide-to-slide transition inside the onboarding pager.
  static const Duration pageTransition = Duration(milliseconds: 300);
}
