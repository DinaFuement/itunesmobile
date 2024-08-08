import 'package:flutter/material.dart';
import 'package:itunes/model/media.dart';

class MediaDetailScreen extends StatelessWidget {
  final MediaItem mediaItem;

  const MediaDetailScreen({super.key, required this.mediaItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mediaItem.title),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(mediaItem.artworkUrl, height: 200),
              ),
              const SizedBox(height: 20),
              Text(
                mediaItem.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                mediaItem.artist,
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              if (mediaItem.previewUrl != null)
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Preview'),
                        content: const SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: Text('Coming Soon'),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Close'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Play'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Play Preview'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
