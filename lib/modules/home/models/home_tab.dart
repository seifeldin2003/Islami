import '../../../core/app_assets.dart';
import '../../../core/app_strings.dart';

/// The five destinations of the bottom navigation bar, left to right.
enum HomeTab {
  quran(AppStrings.tabQuran, AppAssets.icQuran),
  hadeth(AppStrings.tabHadeth, AppAssets.icHadeth),
  sebha(AppStrings.tabSebha, AppAssets.icSebha),
  radio(AppStrings.tabRadio, AppAssets.icRadio),
  times(AppStrings.tabTime, AppAssets.icTime);

  const HomeTab(this.label, this.icon);

  final String label;
  final String icon;
}
