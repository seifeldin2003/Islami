import '../../../core/app_assets.dart';
import '../../../core/app_strings.dart';

/// One onboarding slide.
class IntroPageData {
  const IntroPageData({
    required this.illustration,
    required this.title,
    this.body,
  });

  final String illustration;
  final String title;
  final String? body;
}

const List<IntroPageData> introPages = <IntroPageData>[
  IntroPageData(
    illustration: AppAssets.introWelcome,
    title: AppStrings.slide1Title,
  ),
  IntroPageData(
    illustration: AppAssets.introKaaba,
    title: AppStrings.slide2Title,
    body: AppStrings.slide2Body,
  ),
  IntroPageData(
    illustration: AppAssets.introQuran,
    title: AppStrings.slide3Title,
    body: AppStrings.slide3Body,
  ),
  IntroPageData(
    illustration: AppAssets.introHands,
    title: AppStrings.slide4Title,
    body: AppStrings.slide4Body,
  ),
  IntroPageData(
    illustration: AppAssets.introRadio,
    title: AppStrings.slide5Title,
    body: AppStrings.slide5Body,
  ),
];
