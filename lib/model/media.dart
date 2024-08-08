class MediaItem {
  final String artworkUrl;
  final String title;
  final String artist;
  final String? previewUrl;
  final String type;

  MediaItem({
    required this.artworkUrl,
    required this.title,
    required this.artist,
    this.previewUrl,
    required this.type,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      artworkUrl: json['artworkUrl100'] ?? '',
      title: json['trackName'] ?? json['collectionName'] ?? 'No title',
      artist: json['artistName'] ?? 'Unknown artist',
      previewUrl: json['previewUrl'],
      type: json['kind'] ?? 'unknown',
    );
  }
}
