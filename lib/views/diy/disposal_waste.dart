// lib/pages/disposal_waste.dart

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'recycle_electronics.dart'; // Import the VideoPlaybackManager and FullscreenVideoPage classes

class DisposalWastePage extends StatelessWidget {
  final String title;

  const DisposalWastePage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    const offWhite = Color(0xFFF5F7F6);

    // 🎥 Video list for this page
    final List<Map<String, String>> videos = [
      {
        "path": "images/viddispose1.mp4",
        "title": "E-Waste Processing",
      },
      {
        "path": "images/viddispose2.mp4",
        "title": "How E-Waste is Recycled",
      },
      {
        "path": "images/viddispose3.mp4",
        "title": "What Happens to E-Waste",
      },
    ];

    return Scaffold(
      backgroundColor: offWhite,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF94CF96),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return _VideoCard(
              videoPath: video["path"]!,
              title: video["title"]!,
            );
          },
        ),
      ),
    );
  }
}

class _VideoCard extends StatefulWidget {
  final String videoPath;
  final String title;

  const _VideoCard({
    required this.videoPath,
    required this.title,
  });

  @override
  State<_VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<_VideoCard> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openFullscreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullscreenVideoPage(videoPath: widget.videoPath),
      ),
    );
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        VideoPlaybackManager().setActiveController(_controller);
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openFullscreen,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _controller.value.isInitialized
                  ? FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    )
                  : const Center(
                      child:
                          Icon(Icons.videocam, size: 40, color: Colors.grey),
                    ),
              
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              
              Positioned(
                bottom: 8,
                right: 8,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.black54,
                  onPressed: _togglePlayPause,
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}