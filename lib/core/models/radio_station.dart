/// One Qur'an radio station.
class RadioStation {
  const RadioStation({
    required this.id,
    required this.name,
    required this.url,
  });

  factory RadioStation.fromJson(Map<String, dynamic> json) => RadioStation(
        id: json['id'] as int,
        name: json['name'] as String,
        url: json['url'] as String,
      );

  final int id;
  final String name;

  /// Streaming endpoint.
  final String url;

  @override
  bool operator ==(Object other) =>
      other is RadioStation && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
