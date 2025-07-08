import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

class CarImageViewer extends StatefulWidget {
  final List<String> imageUrls;

  const CarImageViewer({super.key, required this.imageUrls});

  @override
  State<CarImageViewer> createState() => _CarImageViewerState();
}

class _CarImageViewerState extends State<CarImageViewer> {
  int _currentIndex = 0;

  void _openFullScreen(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(backgroundColor: Colors.black),
          body: Center(
            child: PhotoView(
              imageProvider: NetworkImage(imageUrl.trim()),
              backgroundDecoration: const BoxDecoration(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.imageUrls;

    if (images.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(child: Text('No image available')),
      );
    }

    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            return GestureDetector(
              onTap: () => _openFullScreen(images[index]),
              child: Container(
                width: double.infinity,
                height: 300,
                //margin: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                  //borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 300,
            viewportFraction: 1,
            enableInfiniteScroll: images.length > 1,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),
        if (images.length > 1)
          Positioned(
            bottom: 10,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_currentIndex + 1} / ${images.length}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
