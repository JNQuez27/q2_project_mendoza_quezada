// lib/pages/diy_page.dart

import 'package:flutter/material.dart';
import 'repair_detail.dart';
import 'guide_detail_page.dart';
import 'recycle_electronics.dart';
import 'disposal_waste.dart';
import 'sustainable_tips.dart';

class DiyPage extends StatelessWidget {
  const DiyPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF94CF96);
    const offWhite = Color(0xFFF5F7F6);

    return Scaffold(
      backgroundColor: offWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search repair guides",
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 4),

            // 🚀 Quick Guides Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Quick Guides",
                style: TextStyle(
                  color: primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _quickGuideCard(
                    context,
                    "images/quick_guide1.png",
                    "Recycling Electronics",
                    [],
                  ),
                  const SizedBox(width: 12),
                  _quickGuideCard(
                    context,
                    "images/quick_guide2.jpg",
                    "Disposing of E-Waste",
                    [],
                  ),
                  const SizedBox(width: 12),
                  _quickGuideCard(
                    context,
                    "images/quick_guide3.png",
                    "Sustainable Tips",
                    [],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 🛠 Repair Guides Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Repair Guides",
                style: TextStyle(
                  color: primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: repairGuides.length,
                itemBuilder: (context, index) {
                  final guide = repairGuides[index];
                  final subtitle = guide["subtitle"] as String;

                  // shorten description (2 lines with ellipsis effect)
                  final shortSubtitle = subtitle.length > 80
                      ? "${subtitle.substring(0, 80)}..."
                      : subtitle;

                  return RepairCard(
                    title: guide["title"] as String,
                    subtitle: shortSubtitle,
                    icon: guide["icon"] as IconData,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RepairGuideDetailPage(
                            title: guide["title"] as String,
                            description: guide["subtitle"] as String,
                            icon: guide["icon"] as IconData,
                            videoPath: guide["videoPath"] as String,
                            steps: (guide["steps"] as List).cast<String>(),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Quick Guide Card Widget
  Widget _quickGuideCard(
    BuildContext context,
    String assetPath,
    String title,
    List<String> videos,
  ) {
    return GestureDetector(
      onTap: () {
        if (title == "Recycling Electronics") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecycleElectronicsPage(title: title),
            ),
          );
        } else if (title == "Disposing of E-Waste") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisposalWastePage(title: title),
            ),
          );
        } else if (title == "Sustainable Tips") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SustainableTipsPage(title: title),
            ),
          );
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.asset(assetPath, width: 200, height: 120, fit: BoxFit.cover),
            Container(
              width: 200,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Reusable RepairCard
class RepairCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const RepairCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF94CF96);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFEAF7EA),
          child: Icon(icon, color: primaryGreen),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        onTap: onTap,
      ),
    );
  }
}
