import '../app_assets.dart';
import '../app_strings.dart';

/// The four azkar collections the home grid offers, mapped onto the
/// Arabic keys used inside `assets/data/azkar.json`.
enum AzkarCategory {
  evening(AppStrings.azkarEvening, 'أذكار المساء', AppAssets.azkarEvening),
  morning(AppStrings.azkarMorning, 'أذكار الصباح', AppAssets.azkarMorning),
  waking(AppStrings.azkarWaking, 'أذكار الاستيقاظ', AppAssets.azkarWaking),
  sleeping(AppStrings.azkarSleeping, 'أذكار النوم', AppAssets.azkarSleeping);

  const AzkarCategory(this.title, this.jsonKey, this.icon);

  /// Card title, as written in the design.
  final String title;

  /// Key this collection sits under in `azkar.json`.
  final String jsonKey;

  final String icon;
}
