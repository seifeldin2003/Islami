/// One remembrance from the azkar collection.
class Zikr {
  const Zikr({required this.content, required this.repeat});

  factory Zikr.fromJson(Map<String, dynamic> json) => Zikr(
        content: (json['content'] as String? ?? '').trim(),
        repeat: int.tryParse(json['count'] as String? ?? '') ?? 1,
      );

  final String content;

  /// How many times it is repeated; the data set stores this as a string.
  final int repeat;
}
