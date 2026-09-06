import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../app_assets.dart';
import '../models/radio_station.dart';

/// Supplies the Qur'an radio line-up.
///
/// The bundled snapshot in `assets/data/radios.json` is the primary source,
/// so the list appears instantly and works with no connection at all. A
/// refresh from mp3quran.net — the same source the Figma mock-up was
/// populated from — runs afterwards and updates [line] if it succeeds.
class RadioRepository {
  const RadioRepository._();

  static final Uri endpoint =
      Uri.parse('https://mp3quran.net/api/v3/radios?language=eng');

  static const Duration networkTimeout = Duration(seconds: 5);

  /// The line-up currently on offer; empty until [load] has run.
  static final ValueNotifier<List<RadioStation>> line =
      ValueNotifier<List<RadioStation>>(const <RadioStation>[]);

  static bool _loaded = false;

  /// Publishes the bundled line-up, then refreshes it in the background.
  static Future<List<RadioStation>> load() async {
    if (_loaded) return line.value;

    line.value = await _fromBundle();
    _loaded = true;
    unawaited(_refresh());
    return line.value;
  }

  static Future<void> _refresh() async {
    final live = await _fromNetwork();
    if (live != null && live.isNotEmpty) line.value = live;
  }

  static Future<List<RadioStation>?> _fromNetwork() async {
    try {
      final response = await http.get(endpoint).timeout(networkTimeout);
      if (response.statusCode != 200) return null;
      return _parse(response.body);
    } catch (error) {
      debugPrint('Radio line-up falling back to the bundled list: $error');
      return null;
    }
  }

  static Future<List<RadioStation>> _fromBundle() async =>
      _parse(await rootBundle.loadString(AppAssets.radiosData));

  static List<RadioStation> _parse(String body) {
    final decoded = jsonDecode(body) as Map<String, dynamic>;
    final radios = decoded['radios'] as List<dynamic>;
    return List<RadioStation>.unmodifiable(
      radios.map(
        (entry) => RadioStation.fromJson(entry as Map<String, dynamic>),
      ),
    );
  }

  @visibleForTesting
  static void clearCache() {
    _loaded = false;
    line.value = const <RadioStation>[];
  }

  @visibleForTesting
  static List<RadioStation> parse(String body) => _parse(body);
}
