import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/sura.dart';
import 'suras_data.dart';

/// Remembers which suras were opened last, newest first.
///
/// Backs the "Most Recently" carousel on the home screen; the sura detail
/// screen calls [markOpened] when a sura is read.
class RecentSurasStore extends ChangeNotifier {
  RecentSurasStore._();

  static final RecentSurasStore instance = RecentSurasStore._();

  static const String _storageKey = 'recent_sura_numbers';
  static const int maxEntries = 10;

  List<Sura> _recents = const <Sura>[];

  /// Most recently opened suras, newest first.
  List<Sura> get recents => _recents;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_storageKey) ?? const <String>[];
    _recents = _toSuras(stored);
    notifyListeners();
  }

  Future<void> markOpened(Sura sura) async {
    final updated = <Sura>[sura, ..._recents.where((s) => s != sura)];
    _recents = updated.take(maxEntries).toList(growable: false);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _storageKey,
      _recents.map((s) => s.number.toString()).toList(growable: false),
    );
  }

  /// Drops the in-memory cache so each test starts from a clean slate.
  @visibleForTesting
  void reset() {
    _recents = const <Sura>[];
    notifyListeners();
  }

  static List<Sura> _toSuras(List<String> stored) {
    final suras = <Sura>[];
    for (final entry in stored) {
      final number = int.tryParse(entry);
      if (number == null || number < 1 || number > SurasData.count) continue;
      suras.add(SurasData.all[number - 1]);
    }
    return List<Sura>.unmodifiable(suras);
  }
}
