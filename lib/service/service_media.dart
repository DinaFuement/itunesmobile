
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:itunes/model/media.dart';
import 'dart:convert';

final mediaProvider = StateNotifierProvider<MediaViewModel, List<MediaItem>>(
  (ref) => MediaViewModel(),
);

class MediaViewModel extends StateNotifier<List<MediaItem>> {
  MediaViewModel() : super([]);

  Future<void> fetchMedia(String searchTerm) async {
    final url = 'https://itunes.apple.com/search?term=$searchTerm&media=all';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<MediaItem> mediaItems = (jsonData['results'] as List)
            .map((item) => MediaItem.fromJson(item))
            .toList();
        state = mediaItems;
      } else {
        state = [];
      }
    } catch (e) {
      // Handle error
      state = [];
    }
  }
}

