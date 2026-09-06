import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/hadith.dart';

/// Reads the hadith collection out of `assets/hadeeth/`.
///
/// Each file's first non-empty line is the title and the rest are the body
/// paragraphs. Some files carry a doubled byte-order mark, so every line is
/// trimmed before use.
class HadithRepository {
  const HadithRepository._();

  /// Number of hadiths in the bundled collection.
  static const int count = 50;

  static List<Hadith>? _cache;

  /// Every hadith, in file order.
  static Future<List<Hadith>> all() async {
    final cached = _cache;
    if (cached != null) return cached;

    final hadiths = <Hadith>[];
    for (var number = 1; number <= count; number++) {
      hadiths.add(await _load(number));
    }

    final result = List<Hadith>.unmodifiable(hadiths);
    _cache = result;
    return result;
  }

  static Future<Hadith> _load(int number) async {
    final raw = await rootBundle.loadString(Hadith.assetOf(number));
    final lines = raw
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList(growable: false);

    return Hadith(
      number: number,
      title: lines.first,
      paragraphs: List<String>.unmodifiable(lines.skip(1)),
    );
  }

  @visibleForTesting
  static void clearCache() => _cache = null;
}
