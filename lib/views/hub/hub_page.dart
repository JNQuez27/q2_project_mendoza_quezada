import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Centralized Styling Constants ---
const Color kPrimaryTextColor = Color(0xFF1A2E35);
const Color kSecondaryTextColor = Color(0xFF6B7280);
const Color kOffWhite = Color(0xFFF5F7F6);
const Color kPrimaryGreen = Color(0xFF94CF96);
const Color kDarkGreen = Color(0xFF6CB06F);
const Color kAccentYellow = Color(0xFFFACC15);

// --- Data Models ---
class UserRecord {
  final String title;
  final String value;
  final IconData icon;
  final String description;
  final List<String>? items;

  UserRecord({
    required this.title,
    required this.value,
    required this.icon,
    required this.description,
    this.items,
  });
}

class Badge {
  final String label;
  final IconData icon;
  final bool isCompleted;

  Badge(this.label, this.icon, {this.isCompleted = false});
}

// --- Main Hub Page ---
class HubPage extends StatelessWidget {
  const HubPage({super.key});

  static final List<UserRecord> _userRecords = [
    UserRecord(
      title: "Toxins Prevented",
      value: "320 kg",
      icon: Icons.warning_amber_rounded,
      description:
          "You have prevented 320 kg of toxins from entering the environment by recycling e-waste responsibly.",
    ),
    UserRecord(
      title: "Items Recycled",
      value: "10",
      icon: Icons.recycling,
      description:
          "You have recycled 10 items. Every item counts towards a cleaner planet!",
      items: [
        "Old Smartphone",
        "Laptop Battery",
        "CRT Monitor",
        "Printer Cartridge",
        "Motherboard",
        "Tablet",
        "Power Adapter",
        "USB Cable",
        "Hard Drive",
        "Keyboard",
      ],
    ),
    UserRecord(
      title: "Badges Earned",
      value: "3",
      icon: Icons.verified,
      description:
          "You have earned 3 badges. Tap to view all your accomplishments.",
    ),
  ];

  static final List<Badge> _userBadges = [
    Badge("Recycler", Icons.recycling, isCompleted: true),
    Badge("Eco Saver", Icons.energy_savings_leaf, isCompleted: true),
    Badge("Toxin Preventer", Icons.shield, isCompleted: true),
    Badge("Battery Recycler", Icons.battery_charging_full),
    Badge("Device Donor", Icons.computer),
    Badge("Light Saver", Icons.lightbulb_outline),
    Badge("Mobile Upcycler", Icons.phone_android),
    Badge("Circuit Saviour", Icons.memory),
    Badge("Clean Collector", Icons.cleaning_services),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOffWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Your Hub",
          style: GoogleFonts.poppins(
            color: kPrimaryTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            const _UserInfo(),
            const SizedBox(height: 24),
            _RecordsSection(records: _userRecords, badges: _userBadges),
            const SizedBox(height: 24),
            const _BadgesPreview(), // 🔥 New preview section
            const SizedBox(height: 24),
            const _CommunityImpactCard(),
          ],
        ),
      ),
    );
  }
}

// --- User Info ---
class _UserInfo extends StatelessWidget {
  const _UserInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "profile-pic",
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("images/logo2.png"),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          "Jim Nick Quezada",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: kPrimaryTextColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "jquezada@email.com",
          style: GoogleFonts.lato(fontSize: 15, color: kSecondaryTextColor),
        ),
      ],
    );
  }
}

// --- Records Section ---
class _RecordsSection extends StatelessWidget {
  final List<UserRecord> records;
  final List<Badge> badges;

  const _RecordsSection({required this.records, required this.badges});

  void _showRecordDetails(BuildContext context, UserRecord record) {
    if (record.title == "Items Recycled") {
      showDialog(
        context: context,
        builder: (_) => _ItemsRecycledDialog(record: record),
      );
    } else if (record.title == "Badges Earned") {
      showDialog(
        context: context,
        builder: (_) => _BadgeListDialog(badges: badges),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => _GenericRecordDialog(record: record),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Your Records",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kPrimaryTextColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: records.map((record) {
                return Expanded(
                  child: InkWell(
                    onTap: () => _showRecordDetails(context, record),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: kPrimaryGreen.withOpacity(0.2),
                            child: Icon(record.icon, color: kDarkGreen),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            record.title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontSize: 13,
                              color: kSecondaryTextColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            record.value,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// --- New Badge Preview Section ---
class _BadgesPreview extends StatelessWidget {
  const _BadgesPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Badge Progress",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: kPrimaryTextColor,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _badgeChip("Recycler", Icons.recycling, true),
              _badgeChip("Eco Saver", Icons.energy_savings_leaf, true),
              _badgeChip("Toxin Preventer", Icons.shield, true),
              _badgeChip("Battery Recycler", Icons.battery_charging_full, false),
              _badgeChip("Device Donor", Icons.computer, false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _badgeChip(String label, IconData icon, bool isCompleted) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isCompleted ? kPrimaryGreen.withOpacity(0.2) : Colors.grey[200],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCompleted ? kDarkGreen : Colors.grey.shade400,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isCompleted ? kDarkGreen : Colors.grey),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 12,
              color: isCompleted ? kDarkGreen : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// --- Community Impact Card ---
class _CommunityImpactCard extends StatelessWidget {
  const _CommunityImpactCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [kPrimaryGreen, kDarkGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Community Impact",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Davao City has recycled 1,245 kg of e-waste",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.white,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.white24,
              color: kAccentYellow,
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "70% of our community goal achieved!",
            style: GoogleFonts.lato(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// --- Dialog Widgets ---
class _BadgeListDialog extends StatelessWidget {
  final List<Badge> badges;
  const _BadgeListDialog({required this.badges});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Your Badges", style: GoogleFonts.poppins()),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: badges.length,
          itemBuilder: (context, index) {
            final badge = badges[index];
            return ListTile(
              leading: Icon(
                badge.icon,
                color: badge.isCompleted ? kDarkGreen : Colors.grey,
              ),
              title: Text(badge.label, style: GoogleFonts.lato()),
              trailing: Icon(
                badge.isCompleted
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: badge.isCompleted ? kDarkGreen : Colors.grey,
              ),
              subtitle: Text(
                badge.isCompleted ? "Accomplished" : "Not yet accomplished",
                style: GoogleFonts.lato(fontSize: 12),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}

class _ItemsRecycledDialog extends StatelessWidget {
  final UserRecord record;
  const _ItemsRecycledDialog({required this.record});

  @override
  Widget build(BuildContext context) {
    final items = record.items ?? [];
    return AlertDialog(
      title: Row(
        children: [
          Icon(record.icon, color: kDarkGreen),
          const SizedBox(width: 8),
          Text(record.title, style: GoogleFonts.poppins()),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: items.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.check, color: kDarkGreen),
                    title: Text(items[index], style: GoogleFonts.lato()),
                  );
                },
              )
            : Text("No items recycled yet.", style: GoogleFonts.lato()),
      ),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}

class _GenericRecordDialog extends StatelessWidget {
  final UserRecord record;
  const _GenericRecordDialog({required this.record});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(record.icon, color: kDarkGreen),
          const SizedBox(width: 8),
          Text(record.title, style: GoogleFonts.poppins()),
        ],
      ),
      content: Text(record.description, style: GoogleFonts.lato()),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
