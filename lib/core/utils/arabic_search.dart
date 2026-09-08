/// Text folding used by the sura / hadeth search fields.
///
/// The bundled data spells names one way and users type them another
/// (e.g. `الفاتحه` in the data set vs `الفاتحة` as usually typed), so a
/// plain `contains` misses obvious matches. Folding removes diacritics and
/// collapses the letter forms Arabic typists use interchangeably.
class ArabicSearch {
  const ArabicSearch._();

  /// Harakat, tatweel and the Qur'anic annotation marks.
  static final RegExp _diacritics = RegExp(
    r'[ؐ-ًؚ-ٰٟۖ-ۭـ]',
  );

  static const Map<String, String> _foldings = <String, String>{
    'أ': 'ا',
    'إ': 'ا',
    'آ': 'ا',
    'ٱ': 'ا',
    'ة': 'ه',
    'ى': 'ي',
    'ئ': 'ي',
    'ؤ': 'و',
  };

  /// Lower-cases, trims and normalises [value] for comparison.
  static String fold(String value) {
    final buffer = StringBuffer();
    for (final rune in value.replaceAll(_diacritics, '').runes) {
      final char = String.fromCharCode(rune);
      buffer.write(_foldings[char] ?? char);
    }
    return buffer.toString().toLowerCase().trim();
  }

  /// Whether [haystack] contains [needle] once both are folded.
  static bool matches(String haystack, String needle) =>
      fold(haystack).contains(fold(needle));
}
