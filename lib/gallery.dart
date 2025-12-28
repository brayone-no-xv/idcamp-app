import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  // A list of maps representing the image data for the gallery
  final List<Map<String, dynamic>> _galleryItems = [
    {
      'imageUrl': 'https://picsum.photos/id/1015/600/400',
      'title': 'Mountain Landscape',
      'description': 'A stunning view of a mountain range.',
    },
    {
      'imageUrl': 'https://picsum.photos/id/1025/600/400',
      'title': 'Loyal Companion',
      'description': 'A dog looking out over the landscape.',
    },
    {
      'imageUrl': 'https://picsum.photos/id/103/600/400',
      'title': 'City at Night',
      'description': 'A bustling city street after dark.',
    },
    {
      'imageUrl': 'https://picsum.photos/id/1047/600/400',
      'title': 'Serene Lake',
      'description': 'A calm lake reflecting the sky.',
    },
    {
      'imageUrl': 'https://picsum.photos/id/1062/600/400',
      'title': 'Forest Trail',
      'description': 'A path leading through a lush forest.',
    },
    {
      'imageUrl': 'https://picsum.photos/id/1074/600/400',
      'title': 'Abstract Waves',
      'description': 'Colorful abstract wave patterns.',
    },
     {
      'imageUrl': 'https://picsum.photos/id/10/600/400',
      'title': 'Morning Mist',
      'description': 'A forest covered in a thick layer of mist.',
    },
    {
      'imageUrl': 'https://picsum.photos/id/20/600/400',
      'title': 'Coastal View',
      'description': 'A beautiful view of the coastline from above.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text('Image Gallery'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        titleTextStyle: TextStyle(
          color: Colors.blueGrey[800],
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Display two items per row
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.75, // Adjust for better item proportions
        ),
        itemCount: _galleryItems.length,
        itemBuilder: (context, index) {
          final item = _galleryItems[index];
          return _buildGalleryCard(
            imageUrl: item['imageUrl'],
            title: item['title'],
            description: item['description'],
          );
        },
      ),
    );
  }

  // A widget to build each card in the gallery
  Widget _buildGalleryCard({
    required String imageUrl,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias, // Ensures the image respects the card's border radius
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              // Show a loading indicator while the image is loading
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              // Show an error icon if the image fails to load
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: FaIcon(
                    FontAwesomeIcons.image,
                    color: Colors.grey,
                    size: 40,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
