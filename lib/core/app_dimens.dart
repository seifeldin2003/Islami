/// Sizing tokens taken from the Figma canvas ("Islami – Copy", page `UI`).
///
/// Every screen is authored against a 430 x 932 artboard; use
/// `DesignScale` (see `design_scale.dart`) to map these onto the device.
class AppDimens {
  const AppDimens._();

  // Design canvas -------------------------------------------------------
  static const double designWidth = 430;
  static const double designHeight = 932;

  // Shared --------------------------------------------------------------
  static const double screenPadding = 16;

  // `Islami` header lockup (Figma `img_header` / `Logo`) ----------------
  static const double headerWidth = 291;
  static const double headerHeight = 171;
  static const double headerMosqueHeight = 151;
  static const double headerWordmarkLeft = 63;
  static const double headerWordmarkTop = 75;

  // Intro ---------------------------------------------------------------
  static const double introTitleGap = 16;
  static const double introSlideBottomGap = 24;
  static const double introNavButtonWidth = 48;

  // Home (Figma `Home Screen`, node 27:34072) --------------------------
  static const double homeHeaderTop = 30;
  static const double homeBackdropHeight = 862;
  static const double homeGutter = 20;
  static const double homeSectionGutter = 21;

  static const double searchFieldHeight = 55;
  static const double searchFieldRadius = 10;
  static const double searchIconSize = 28;
  static const double searchIconGap = 15;
  static const double searchFieldPadding = 14;

  static const double recentCardWidth = 283;
  static const double recentCardHeight = 150;
  static const double recentCardRadius = 20;
  static const double recentCardGap = 10;
  static const double recentCardPadding = 17;
  static const double recentCardArtWidth = 153;
  static const double recentCardArtHeight = 136;
  static const double recentCardArtInset = 6;
  static const double recentCardArtTop = 7;
  static const double recentCardTopPadding = 12;
  static const double recentCardBottomPadding = 20;

  static const double suraRowHeight = 73;
  static const double suraRowGap = 10;
  static const double suraNumberSize = 52;
  static const double suraNumberGap = 24;
  static const double dividerWidth = 302;
  static const double suraRowTrailingGutter = 23;

  /// Height of the bar's content. The Figma bar is 80pt tall in total and
  /// draws no home indicator, so the device's bottom inset is added below
  /// this rather than on top of the full 80.
  static const double navBarHeight = 64;
  static const double navPillWidth = 59;
  static const double navPillHeight = 34;
  static const double navPillRadius = 66;
  static const double navIconSize = 26;
  static const double navLabelGap = 2;
  static const double navBarPadding = 6;

  // Home vertical rhythm (Figma y-offsets, top to bottom) ---------------
  static const double homeHeaderGap = 21;
  static const double homeSearchGap = 20;
  static const double homeSectionGap = 10;

  // Hadeth carousel (Figma `Hadith Card`, node 55:4478) ------------------
  static const double hadethBackdropHeight = 567;
  static const double hadithCardTop = 214;
  static const double hadithCardWidth = 313;
  static const double hadithCardHeight = 618;
  static const double hadithCardRadius = 20;
  /// Page extent / canvas width — how much of the screen one card occupies.
  static const double hadithCardViewport = 319 / designWidth;
  /// Neighbouring cards render at 293/313 of the active card.
  static const double hadithCardSideScale = 293 / hadithCardWidth;
  static const double hadithCardCornerSize = 93;
  static const double hadithCardCornerInset = 10;
  static const double hadithCardTitleTop = 43;
  static const double hadithCardBodyTop = 101;
  static const double hadithCardBodyWidth = 266;
  static const double hadithCardMosqueHeight = 89;
  static const double hadithCardTitleGap = 25;
  static const double hadithCardGap = 3;
  static const double hadethHeaderGap = 13;
  static const double hadithDetailGutter = 23;
  static const double hadithCardPadding = 25;
  static const double hadithCardWatermarkOpacity = 0.25;
  /// The watermark covers 428 of the card's 618pt height.
  static const double hadithCardWatermarkHeightFactor = 428 / 618;

  // Sebha (Figma `Sebha` group, node 62:9658) ---------------------------
  static const double sebhaBackdropHeight = 852;
  static const double sebhaVerseTop = 217;
  static const double sebhaHeadTop = 300;
  static const double sebhaHeadWidth = 73;
  static const double sebhaHeadHeight = 86;
  static const double sebhaBodyTop = 379;
  static const double sebhaBodySize = 379;
  static const double sebhaGroupWidth = 379;
  static const double sebhaGroupHeight = 460;
  static const double sebhaHeadLeft = 182;
  static const double sebhaBodyLocalTop = 79;
  static const double sebhaCounterGap = 12;
  static const double sebhaVerseGap = 16;
  static const double sebhaBottomGap = 16;
  /// One bead of the ring; the ring carries 33 beads.
  static const double sebhaBeadTurn = 1 / 33;
  static const int tasbeehTarget = 33;

  // Radio (Figma `Radio Screen`, node 54:12) ----------------------------
  static const double radioBackdropHeight = 852;
  static const double segmentHeight = 40;
  static const double segmentRadius = 12;
  static const double radioTopGap = 7;
  static const double radioCardHeight = 133;
  static const double radioCardRadius = 20;
  static const double radioCardGap = 16;
  static const double radioCardBandHeight = 97;
  static const double radioCardNameTop = 14;
  static const double radioIconSize = 44;
  static const double radioVolumeIconSize = 30;
  static const double radioIconGap = 12;
  static const double radioCardNameInset = 16;

  // Prayer times (Figma `Time Screen`, node 104:18) ---------------------
  static const double timesBackdropHeight = 852;
  static const double prayPanelHeight = 301;
  static const double prayPanelRadius = 20;
  static const double prayHeaderHeight = 76;
  static const double prayTileWidth = 86;
  static const double prayTileHeight = 106;
  static const double prayTileActiveWidth = 104;
  static const double prayTileActiveHeight = 128;
  static const double prayTileRadius = 16;
  static const double prayTileGap = 8;
  static const double prayNextGap = 12;

  // Azkar grid (Figma `Group 19`, node 123:100) -------------------------
  static const double azkarSectionGap = 20;
  static const double azkarCardWidth = 185;
  static const double azkarCardHeight = 259;
  static const double azkarCardRadius = 20;
  static const double azkarCardBorder = 2;
  static const double azkarCardGap = 20;
  static const double azkarCardAspectRatio = 185 / 259;
  static const double azkarCardTitleGap = 6;

  // Detail screens (Figma `Soura Details Screen`, node 135:29) ----------
  static const double detailAppBarHeight = 56;
  static const double detailBackArrowLeft = 32;
  static const double detailBackArrowWidth = 18;
  static const double detailCornerWidth = 93;
  static const double detailCornerHeight = 92;
  static const double detailCornerLeft = 18;
  static const double detailCornerRight = 20;
  static const double detailHeadingTop = 24;
  static const double detailContentGap = 33;
  static const double detailBottomDecorationHeight = 112;

  static const double verseCardGutter = 18;
  static const double verseCardRadius = 15;
  static const double verseCardGap = 8;
  static const double verseCardPadding = 10;
  static const double verseCardTextInset = 16;

  // Onboarding progress indicator (Figma `Progress`, 90 x 7) ------------
  static const double progressDotSize = 7;
  static const double progressDotActiveWidth = 18;
  static const double progressDotGap = 11;
  static const double progressDotRadius = 3.5;
}
