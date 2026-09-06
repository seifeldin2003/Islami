import '../app_assets.dart';

/// One of the fifty hadiths in the bundled collection.
class Hadith {
  const Hadith({
    required this.number,
    required this.title,
    required this.paragraphs,
  });

  /// 1-based index; also the file name under `assets/hadeeth/`.
  final int number;

  /// Arabic title, e.g. `الحد يث الأول`.
  final String title;

  /// Body paragraphs, in order.
  final List<String> paragraphs;

  /// The body as one block of text.
  String get body => paragraphs.join('\n');

  /// Bundled text file for this hadith.
  static String assetOf(int number) => AppAssets.hadith(number);

  @override
  bool operator ==(Object other) => other is Hadith && other.number == number;

  @override
  int get hashCode => number.hashCode;
}
