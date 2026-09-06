import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/sura.dart';

/// Reads verse text out of the bundled `assets/suras/` files.
///
/// Each file holds one verse per line. Results are cached because a sura is
/// re-read every time the reader is reopened.
class SuraRepository {
  const SuraRepository._();

  static final Map<int, List<String>> _cache = <int, List<String>>{};

  /// The verses of [sura], in order, with the byte-order mark and blank
  /// padding lines stripped.
  static Future<List<String>> versesOf(Sura sura) async {
    final cached = _cache[sura.number];
    if (cached != null) return cached;

    final raw = await rootBundle.loadString(sura.versesAsset);
    final verses = raw
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList(growable: false);

    _cache[sura.number] = verses;
    return verses;
  }

  @visibleForTesting
  static void clearCache() => _cache.clear();
}
