import '../app_assets.dart';

/// One sura of the Qur'an, as indexed by the bundled data set.
class Sura {
  const Sura({
    required this.number,
    required this.arabicName,
    required this.englishName,
    required this.versesCount,
  });

  /// 1-based index; also the file name under `assets/suras/`.
  final int number;
  final String arabicName;
  final String englishName;
  final int versesCount;

  /// Bundled verse file for this sura.
  String get versesAsset => AppAssets.suraVerses(number);

  @override
  bool operator ==(Object other) => other is Sura && other.number == number;

  @override
  int get hashCode => number.hashCode;
}
