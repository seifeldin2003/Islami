/// Every bundled asset path, so no raw asset string ever reaches a widget.
class AppAssets {
  const AppAssets._();

  static const String _images = 'assets/images';
  static const String _icons = 'assets/icons';
  static const String _suras = 'assets/suras';
  static const String _hadeeth = 'assets/hadeeth';
  static const String _data = 'assets/data';

  // Splash screen ----------------------------------------------------
  static const String splashBackground = '$_images/background1.png';

  /// Mosque silhouette; used by the splash skyline and the `Islami` header.
  static const String mosqueSilhouette = '$_images/transparent_mousqe.png';
  static const String splashLantern = '$_images/lamb.png';
  static const String splashOrnamentLeft = '$_images/left_panel.png';
  static const String splashOrnamentRight = '$_images/right_panel.png';
  static const String splashLogo = '$_images/isalmi_mousqe.png';
  static const String routeLogo = '$_images/route_logo.png';

  // Intro screens ----------------------------------------------------
  static const String introWelcome = '$_images/intro_welcome.png';
  static const String introKaaba = '$_images/intro_kaaba.png';
  static const String introQuran = '$_images/intro_quran.png';
  static const String introHands = '$_images/intro_hands.png';
  static const String introRadio = '$_images/intro_radio.png';

  // Home screen ------------------------------------------------------
  static const String homeBackground = '$_images/home_background.jpg';
  static const String suraCardArt = '$_images/sura_card_art.png';
  static const String icSearchQuran = '$_icons/ic_search_quran.svg';
  static const String icSuraNumber = '$_icons/ic_sura_number.svg';

  // Bottom navigation ----------------------------------------------------
  static const String icQuran = '$_icons/ic_quran.svg';
  static const String icHadeth = '$_icons/ic_hadeth.svg';
  static const String icSebha = '$_icons/ic_sebha.svg';
  static const String icRadio = '$_icons/ic_radio.svg';
  static const String icTime = '$_icons/ic_time.svg';

  // Hadeth screen ----------------------------------------------------
  static const String hadethBackground = '$_images/hadeth_background.jpg';
  static const String hadithCardCorner = '$_images/hadith_card_corner.png';
  static const String hadithCardWatermark =
      '$_images/hadith_card_watermark.png';

  /// Mosque silhouette band along the foot of a hadith or radio card.
  static const String cardMosqueBand = '$_images/hadith_card_mosque.png';

  // Sebha screen -----------------------------------------------------
  static const String sebhaBackground = '$_images/sebha_background.jpg';
  static const String sebhaHead = '$_images/sebha_head.png';
  static const String sebhaBody = '$_icons/sebha_body.svg';

  // Radio screen -----------------------------------------------------
  static const String radioBackground = '$_images/radio_background.jpg';
  static const String soundWave = '$_icons/sound_wave.svg';

  /// Offline snapshot of the mp3quran radio line-up.
  static const String radiosData = '$_data/radios.json';

  /// The azkar collection shown under the prayer times.
  static const String azkarData = '$_data/azkar.json';

  // Prayer times screen ----------------------------------------------
  static const String timesBackground = '$_images/times_background.jpg';

  // Azkar cards ------------------------------------------------------
  static const String azkarEvening = '$_images/azkar_evening.png';
  static const String azkarMorning = '$_images/azkar_morning.png';
  static const String azkarWaking = '$_images/azkar_waking.png';
  static const String azkarSleeping = '$_images/azkar_sleeping.png';

  // Detail screens ---------------------------------------------------
  // Both are alpha masks: tint them with `BlendMode.srcIn`.
  static const String detailCorner = '$_images/detail_corner.png';
  static const String detailBottomDecoration =
      '$_images/detail_bottom_decoration.png';
  static const String icBackArrow = '$_icons/ic_back_arrow.svg';

  /// Bundled verse file for a 1-based sura [number].
  static String suraVerses(int number) => '$_suras/$number.txt';

  /// Bundled text file for a 1-based hadith [number].
  static String hadith(int number) => '$_hadeeth/h$number.txt';
}
