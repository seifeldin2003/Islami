import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami/core/data/suras_data.dart';

/// Guards the generated `SurasData` table against drifting away from the
/// bundled data set under `assets/suras/`.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('the index carries all 114 suras with matching name lists', () {
    expect(SurasData.count, 114);
    expect(SurasData.arabicNames, hasLength(SurasData.count));
    expect(SurasData.englishNames, hasLength(SurasData.count));
    expect(SurasData.versesCounts, hasLength(SurasData.count));
    expect(SurasData.all, hasLength(SurasData.count));
  });

  test('sura numbers are 1-based and line up with their asset', () {
    for (var i = 0; i < SurasData.count; i++) {
      final sura = SurasData.all[i];
      expect(sura.number, i + 1);
      expect(sura.versesAsset, 'assets/suras/${i + 1}.txt');
    }
  });

  test('every verse file exists and matches its recorded verse count',
      () async {
    for (final sura in SurasData.all) {
      final raw = await rootBundle.loadString(sura.versesAsset);
      final verses =
          raw.split('\n').where((line) => line.trim().isNotEmpty).length;
      expect(
        verses,
        sura.versesCount,
        reason: 'verse count drifted for sura ${sura.number} '
            '(${sura.englishName})',
      );
    }
  });

  test('names are non-empty and unique by number', () {
    expect(SurasData.arabicNames.any((n) => n.trim().isEmpty), isFalse);
    expect(SurasData.englishNames.any((n) => n.trim().isEmpty), isFalse);
    expect(SurasData.all.map((s) => s.number).toSet(), hasLength(114));
  });
}
