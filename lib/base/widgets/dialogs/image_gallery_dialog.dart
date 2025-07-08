import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';

class ImageGalleryDialog extends StatelessWidget {
  final String carName;
  final List<String> imageUrls;

  const ImageGalleryDialog({
    super.key,
    required this.carName,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Images of $carName',
        style: AppStyles.headlineStyle2.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      content: imageUrls.isEmpty
          ? const Text('No gallery images available.')
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Horizontal scrolling for images
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: imageUrls.map((url) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  height: 150, // Fixed height for consistency
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;

                    final double? progressValue =
                    loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null;

                    return Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: progressValue,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}