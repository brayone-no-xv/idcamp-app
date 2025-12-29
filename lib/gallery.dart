import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  // A list of maps representing the image data for the gallery
  final List<Map<String, dynamic>> _galleryItems = const [
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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _getCrossAxisCount(context), // Responsive grid
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.75, // Adjust for better item proportions
        ),
        itemCount: _galleryItems.length,
        itemBuilder: (context, index) {
          final item = _galleryItems[index];
          return GestureDetector(
            onTap: () => _showImageDialog(context, item),
            child: _buildGalleryCard(
              imageUrl: item['imageUrl'],
              title: item['title'],
              description: item['description'],
            ),
          );
        },
      ),
    );
  }

  // Helper method to get responsive grid count based on screen width
  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) {
      return 4; // Large screens
    } else if (width > 800) {
      return 3; // Medium screens
    } else {
      return 2; // Small screens
    }
  }

  // A widget to build each card in the gallery
  Widget _buildGalleryCard({
    required String imageUrl,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 4,
      clipBehavior:
          Clip.antiAlias, // Ensures the image respects the card's border radius
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

  // Method to show image dialog when tapped
  void _showImageDialog(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image
                Flexible(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      item['imageUrl'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40.0),
                            child: Icon(
                              Icons.error,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['description'],
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
