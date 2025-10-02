// result_page.dart
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String scannedResult;
  const ResultPage({super.key, required this.scannedResult});

  // Map each scanned item to its hazard & disposal info
  Map<String, dynamic> getItemInfo(String item) {
    switch (item) {
      case "Lithium Battery":
        return {
          "hazard":
              "Lithium batteries can leak toxic chemicals and may catch fire if damaged. Dispose properly to prevent environmental harm and health risks.",
          "options": [
            {
              "icon": Icons.battery_charging_full,
              "title": "Battery Recycling Bin",
              "subtitle": "Specialized bin for safe disposal",
              "why":
                  "Prevents toxic leakage and recovers valuable materials like lithium and cobalt.",
              "prep": "Tape battery terminals to prevent short circuits.",
            },
            {
              "icon": Icons.archive_outlined,
              "title": "Small Electronics Drop-off",
              "subtitle": "For items containing embedded batteries",
              "why":
                  "Ensures that entire devices are disassembled correctly and hazardous materials are handled safely.",
              "prep":
                  "Remove personal data before dropping off to protect privacy.",
            },
          ],
        };
      case "Mouse":
        return {
          "hazard":
              "This mouse may contain small batteries and electronic components that are hazardous. Dispose of it properly to avoid environmental contamination and health risks.",
          "options": [
            {
              "icon": Icons.battery_charging_full,
              "title": "Battery Recycling Bin",
              "subtitle": "For mice containing small batteries",
              "why":
                  "Prevents leakage of toxic chemicals from batteries and recovers valuable materials like lithium.",
              "prep": "Remove the battery from the mouse before disposal. Tape terminals if needed.",
            },
            {
              "icon": Icons.archive_outlined,
              "title": "Small Electronics Drop-off",
              "subtitle": "Dispose of the mouse as electronic waste",
              "why":
                  "Ensures safe handling of components and recovers recyclable materials like plastic and metals.",
              "prep": "Remove any batteries and cables before dropping off.",
            },
          ],
        };
      case "RAM":
        return {
          "hazard":
              "RAM modules contain metals and chemicals that can be hazardous if improperly disposed. Avoid throwing them in regular trash to prevent environmental contamination.",
          "options": [
            {
              "icon": Icons.memory,
              "title": "Electronics Recycling Center",
              "subtitle": "Specialized for RAM and computer components",
              "why":
                  "Recovers valuable metals like gold, copper, and rare earth elements while preventing toxic chemicals from entering the environment.",
              "prep": "Handle RAM with care and avoid breaking modules before dropping off.",
            },
            {
              "icon": Icons.archive_outlined,
              "title": "E-Waste Drop-off",
              "subtitle": "General electronic waste collection",
              "why": "Ensures safe disassembly and recycling of electronic components.",
              "prep": "Package RAM safely to prevent physical damage during transport.",
            },
          ],
        };
      default:
        return {
          "hazard":
              "This item may be hazardous. Please dispose of it properly to avoid environmental harm and health risks.",
          "options": [],
        };
    }
  }

  void _showEcoTips(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Eco-Friendly Tips",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12),
              _Tip(
                icon: Icons.eco,
                text:
                    "Choose rechargeable batteries over single-use ones to reduce waste.",
              ),
              SizedBox(height: 8),
              _Tip(
                icon: Icons.check_box_outlined,
                text:
                    "Look for products with easily replaceable batteries to extend their lifespan.",
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemInfo = getItemInfo(scannedResult);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: const Color(0xFFF5F7F6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  ),
                  const Text(
                    "Result",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Scanned Result
                    Text(
                      scannedResult,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Hazard Information
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0x33F2C94C),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            color: Color(0xFFF2C94C),
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              itemInfo['hazard'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                height: 1.4,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Disposal Options Section
                    const Text(
                      "Disposal Options",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...List<Widget>.from(
                      itemInfo['options'].map<Widget>((option) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _OptionCard(
                            icon: option['icon'],
                            title: option['title'],
                            subtitle: option['subtitle'],
                            why: option['why'],
                            prep: option['prep'],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button for Eco-Friendly Tips
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showEcoTips(context),
        backgroundColor: Colors.green,
        icon: const Icon(Icons.lightbulb_outline, color: Colors.white),
        label: const Text(
          "Tips",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

/// -------------------- Private Widgets --------------------
class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String why;
  final String prep;

  const _OptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.why,
    required this.prep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF94CF96),
                radius: 24,
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(subtitle,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            margin: const EdgeInsets.only(left: 12),
            padding: const EdgeInsets.only(left: 12),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFFD1D5DB), width: 2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Why this is important:",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.grey.shade800)),
                const SizedBox(height: 4),
                Text(why,
                    style: const TextStyle(fontSize: 13, color: Colors.black87)),
                const SizedBox(height: 8),
                Text("Preparation:",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.grey.shade800)),
                const SizedBox(height: 4),
                Text(prep,
                    style: const TextStyle(fontSize: 13, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Tip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green.shade600, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
