/// Every user-facing string in the app.
///
/// Copy is transcribed verbatim from the design; nothing is authored
/// inline in a widget.
class AppStrings {
  const AppStrings._();

  static const String appTitle = 'Islami';

  // Splash --------------------------------------------------------------
  static const String supervisedBy = 'Supervised by Mohamed Nabil';

  // Home ----------------------------------------------------------------
  static const String searchHint = 'Sura Name';
  static const String mostRecently = 'Most Recently';
  static const String surasList = 'Suras List';

  /// "7 Verses" — the verse count shown under each sura name.
  static String verses(int count) => '$count Verses';

  // Sura details --------------------------------------------------------
  /// "[1] verse text" — the numbered verse line inside a verse card.
  static String verse(int number, String text) => '[$number] $text';

  // Hadeth --------------------------------------------------------------
  /// "Hadith 1" — the detail screen's app bar title.
  static String hadithNumber(int number) => 'Hadith $number';

  // Sebha ---------------------------------------------------------------
  /// Qur'an 87:1, the verse above the beads.
  static const String sebhaVerse = 'سَبِّحِ اسْمَ رَبِّكَ الأعلى';

  /// The tasbeeh phrases, cycled every [tasbeehTarget] taps.
  ///
  /// The design only shows `سبحان الله`; the remaining three are the
  /// customary tasbeeh that follows it.
  static const List<String> tasbeehPhrases = <String>[
    'سبحان الله',
    'الحمد لله',
    'لا إله إلا الله',
    'الله أكبر',
  ];

  // Radio ---------------------------------------------------------------
  static const String segmentRadio = 'Radio';
  static const String segmentReciters = 'Reciters';
  static const String radioSearchHint = 'Station Name';

  /// Shown when a search matches nothing.
  static const String noMatches = 'No matches found';

  /// Shown when a station will not open.
  static const String radioUnavailable = 'This station is unavailable';

  /// Accessibility label for a station's mute control.
  static const String volume = 'Volume';

  // Prayer times ---------------------------------------------------------
  static const String prayTime = 'Pray Time';

  /// `intl` patterns behind the panel header and the prayer tiles.
  static const String gregorianPattern = 'dd MMM,\nyyyy';
  static const String weekdayPattern = 'EEEE';
  static const String clockPattern = 'hh:mm';
  static const String meridiemPattern = 'a';

  /// "Next Pray - 02:32" — time remaining until the next prayer.
  static String nextPray(String remaining) => 'Next Pray - $remaining';

  /// Prayer labels, spelled as the design spells them.
  static const String fajr = 'Fajr';
  static const String sunrise = 'Sunrise';
  static const String dhuhr = 'Dhuhr';
  static const String asr = 'ASR';
  static const String maghrib = 'Maghrib';
  static const String isha = 'Isha';

  // Azkar -----------------------------------------------------------------
  static const String azkarSection = 'Azkar';
  static const String azkarEvening = 'Evening Azkar';
  static const String azkarMorning = 'Morning Azkar';
  static const String azkarWaking = 'Waking Azkar';
  static const String azkarSleeping = 'Sleeping Azkar';

  // Bottom navigation ----------------------------------------------------
  // The design labels the Sebha tab "Hadith" — a duplicated label — so
  // this one reads "Sebha" instead.
  static const String tabQuran = 'Quran';
  static const String tabHadeth = 'Hadith';
  static const String tabSebha = 'Sebha';
  static const String tabRadio = 'Radio';
  static const String tabTime = 'Time';

  // Onboarding navigation ------------------------------------------------
  static const String back = 'Back';
  static const String next = 'Next';
  static const String finish = 'Finish';

  // Intro slides ---------------------------------------------------------
  // `slide1Title` and `slide4Title` reproduce the design copy exactly,
  // typos included; they are deliberate, not mistakes.
  static const String slide1Title = 'Welcome To Islmi App';

  static const String slide2Title = 'Welcome To Islami';
  static const String slide2Body =
      'We Are Very Excited To Have You In Our Community';

  static const String slide3Title = 'Reading the Quran';
  static const String slide3Body = 'Read, and your Lord is the Most Generous';

  static const String slide4Title = 'Bearish';
  static const String slide4Body =
      'Praise the name of your Lord, the Most High';

  static const String slide5Title = 'Holy Quran Radio';
  static const String slide5Body =
      'You can listen to the Holy Quran Radio through the application '
      'for free and easily';
}
