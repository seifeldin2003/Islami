import 'package:flutter_test/flutter_test.dart';

import 'package:islami/core/data/suras_data.dart';
import 'package:islami/core/utils/arabic_search.dart';

void main() {
  test('folding collapses the interchangeable Arabic letter forms', () {
    expect(ArabicSearch.fold('الفاتحة'), ArabicSearch.fold('الفاتحه'));
    expect(ArabicSearch.fold('إبراهيم'), ArabicSearch.fold('ابراهيم'));
    expect(ArabicSearch.fold('مُحَمَّد'), 'محمد');
  });

  test('the Figma search query matches the data set spelling', () {
    // The mock-up types `الفاتحة`; the data set stores `الفاتحه`.
    final matches = SurasData.all
        .where((s) => ArabicSearch.matches(s.arabicName, 'الفاتحة'))
        .toList();

    expect(matches, hasLength(1));
    expect(matches.single.number, 1);
  });

  test('English search is case-insensitive and partial', () {
    final matches = SurasData.all
        .where((s) => ArabicSearch.matches(s.englishName, 'baqarah'))
        .toList();

    expect(matches.single.englishName, 'Al-Baqarah');
  });

  test('an unmatched query returns nothing', () {
    expect(
      SurasData.all.where((s) => ArabicSearch.matches(s.englishName, 'zzzz')),
      isEmpty,
    );
  });
}
