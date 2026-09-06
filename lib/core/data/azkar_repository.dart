import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../app_assets.dart';
import '../models/azkar_category.dart';
import '../models/zikr.dart';

/// Reads `assets/data/azkar.json`.
///
/// The file is a map of Arabic category name to a list of entries; some
/// categories nest their entries one level deeper, so both shapes are
/// flattened here.
class AzkarRepository {
  const AzkarRepository._();

  static Map<String, dynamic>? _cache;

  static Future<List<Zikr>> of(AzkarCategory category) async {
    final root = _cache ??= jsonDecode(
      await rootBundle.loadString(AppAssets.azkarData),
    ) as Map<String, dynamic>;

    final entries = root[category.jsonKey] as List<dynamic>? ?? const [];
    return List<Zikr>.unmodifiable(_flatten(entries));
  }

  static Iterable<Zikr> _flatten(List<dynamic> entries) sync* {
    for (final entry in entries) {
      if (entry is List<dynamic>) {
        yield* _flatten(entry);
      } else if (entry is Map<String, dynamic>) {
        final zikr = Zikr.fromJson(entry);
        if (zikr.content.isNotEmpty) yield zikr;
      }
    }
  }

  @visibleForTesting
  static void clearCache() => _cache = null;
}
