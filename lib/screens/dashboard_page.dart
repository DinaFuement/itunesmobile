import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes/screens/preview_page.dart';
import 'package:itunes/service/service_media.dart';

class MediaSearchScreen extends ConsumerWidget {
  const MediaSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaItems = ref.watch(mediaProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('iTunes Media Search'),
          backgroundColor: Colors.blueGrey,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 4.0,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                child: Text(
                  "GridView",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  "ListView",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.blueGrey[50],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    ref.read(mediaProvider.notifier).fetchMedia(value);
                  },
                ),
              ),
              Expanded(
                child: mediaItems.isEmpty
                    ? const Center(child: Text('No results found'))
                    : TabBarView(
                        children: [
                          GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 4,
                            ),
                            itemCount: mediaItems.length,
                            itemBuilder: (context, index) {
                              final item = mediaItems[index];
                              final color = getColorForType(item.type);
                              return Card(
                                color: color,
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 20),
                                    ),
                                    Image.network(item.artworkUrl),
                                    Text(
                                      item.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(item.artist),
                                    if (item.previewUrl != null)
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MediaDetailScreen(
                                                      mediaItem: item),
                                            ),
                                          );
                                        },
                                        child: const Text('Preview'),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: mediaItems.length,
                            itemBuilder: (context, index) {
                              final item = mediaItems[index];
                              final color = getColorForType(item.type);
                              return Card(
                                color: color,
                                child: ListTile(
                                  leading: Image.network(item.artworkUrl),
                                  title: Text(
                                    item.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(item.artist),
                                  trailing: item.previewUrl != null
                                      ? ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MediaDetailScreen(
                                                        mediaItem: item),
                                              ),
                                            );
                                          },
                                          child: const Text('Preview'),
                                        )
                                      : null,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getColorForType(String type) {
    switch (type) {
      case 'song':
        return Colors.lightBlue[100]!;
      case 'album':
        return Colors.green[100]!;
      case 'movie':
        return Colors.purple[100]!;
      case 'podcast':
        return Colors.orange[100]!;
      default:
        return Colors.grey[200]!;
    }
  }
}
