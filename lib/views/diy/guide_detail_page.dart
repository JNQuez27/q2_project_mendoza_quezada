import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class GuideDetailPage extends StatelessWidget {
  final String title;

  const GuideDetailPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF94CF96),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Details for "$title" go here.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}

// The detailed page for a specific "Repair Guide"
class RepairGuideDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final String videoPath;
  final List<String> steps;

  const RepairGuideDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.videoPath,
    required this.steps,
  });

  @override
  State<RepairGuideDetailPage> createState() => _RepairGuideDetailPageState();
}

class _RepairGuideDetailPageState extends State<RepairGuideDetailPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF94CF96);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: primaryGreen,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🎥 Video Player Widget
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    width: 500, // 👈 fixed width
                    height: 300, // 👈 fixed height
                    color: Colors.black12,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                        IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            color: primaryGreen,
                            size: 60,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                _controller.play();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            const SizedBox(height: 20),

            // Title & icon
            Row(
              children: [
                Icon(widget.icon, size: 40, color: primaryGreen),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Description
 // Description
Text(
  widget.description,
  style: const TextStyle(
    fontSize: 16,
    color: Colors.black87,
    height: 1.5,
  ),
),
const SizedBox(height: 20),

// Steps
const Text(
  "Steps:",
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 10),
...widget.steps.asMap().entries.map(
  (entry) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            entry.value,
            style: const TextStyle(
              fontSize: 16,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}
