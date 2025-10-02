// lib/pages/encyclopedia_entry_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'gadget_model.dart';

class EncyclopediaEntryPage extends StatelessWidget {
  final Gadget gadget;

  const EncyclopediaEntryPage({super.key, required this.gadget});

  @override
  Widget build(BuildContext context) {
    const offWhite = Color(0xFFF5F7F6);
    const darkText = Color(0xFF374151);
    const lightText = Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: offWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, gadget.image),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gadget.name,
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: darkText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      gadget.description,
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: lightText,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionCard(
                      title: "Hazardous Materials ☣️",
                      subtitle: "Can harm our environment and health.",
                      icon: Icons.warning_amber_rounded,
                      color: Colors.orange,
                      materials: gadget.hazardous,
                    ),
                    const SizedBox(height: 16),
                    _buildSectionCard(
                      title: "Valuable Materials 💎",
                      subtitle: "Can be recovered and recycled.",
                      icon: Icons.diamond_outlined,
                      color: Colors.blue,
                      materials: gadget.valuable,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Proper Disposal in Davao City",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDisposalButton(
                      context,
                      icon: Icons.map_outlined,
                      label: "Find a Drop-off Point",
                    ),
                    const SizedBox(height: 12),
                    _buildDisposalButton(
                      context,
                      icon: Icons.local_shipping_outlined,
                      label: "Schedule a Pickup",
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

  Widget _buildHeader(BuildContext context, String imagePath) {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.4),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required List<MaterialInfo> materials,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: const Color(0xFF374151),
                        )),
                    Text(subtitle,
                        style:
                            GoogleFonts.lato(color: const Color(0xFF6B7280))),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24, thickness: 1),
          ...materials.map((m) =>
              _MaterialInfoTile(name: m.name, description: m.description)),
        ],
      ),
    );
  }

  Widget _buildDisposalButton(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    const primaryGreen = Color(0xFF94CF96);
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
    );
  }
}

class _MaterialInfoTile extends StatelessWidget {
  final String name;
  final String description;

  const _MaterialInfoTile({required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Icon(Icons.circle, size: 8, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF374151))),
                Text(description,
                    style: GoogleFonts.lato(color: const Color(0xFF6B7280))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}