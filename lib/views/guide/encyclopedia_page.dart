// lib/pages/encyclopedia_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'guide_page.dart';
import 'gadget_model.dart';

class EncyclopediaPage extends StatelessWidget {
  EncyclopediaPage({super.key});

  final List<Gadget> gadgets = [
    Gadget(
      name: "Smartphone",
      description:
          "A pocket-sized marvel of engineering, full of valuable and hazardous materials.",
      image: "images/ency1.png",
      hazardous: [
        MaterialInfo("Lead", "Found in solder, harmful to the brain."),
        MaterialInfo("Mercury", "Used in old screens, toxic to nerves."),
        MaterialInfo("Lithium", "In batteries, can catch fire."),
      ],
      valuable: [
        MaterialInfo(
          "Gold & Silver",
          "Circuit boards contain more gold than ore.",
        ),
        MaterialInfo("Copper", "Used in wiring, highly recyclable."),
        MaterialInfo("Palladium", "Rare, valuable, used in micro-components."),
      ],
    ),
    Gadget(
      name: "Laptop",
      description:
          "Laptops contain heavy metals and plastics, but also valuable rare earths.",
      image: "images/ency2.png",
      hazardous: [
        MaterialInfo("Cadmium", "In batteries, damages kidneys."),
        MaterialInfo(
          "Brominated flame retardants",
          "Toxic chemicals in casings.",
        ),
      ],
      valuable: [
        MaterialInfo("Aluminum", "Lightweight casing, easily recyclable."),
        MaterialInfo("Rare Earth Elements", "Used in screens and magnets."),
      ],
    ),
    Gadget(
      name: "Television",
      description: "Older CRT TVs contain high levels of lead and phosphors.",
      image: "images/ency3.png",
      hazardous: [
        MaterialInfo("Lead Glass", "Dangerous if broken."),
        MaterialInfo("Phosphor Coating", "Toxic dust inside CRTs."),
      ],
      valuable: [
        MaterialInfo("Copper", "Coils and wiring."),
        MaterialInfo("Plastics", "Can be recycled for other products."),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: gadgets.length,
        itemBuilder: (context, index) {
          final gadget = gadgets[index];
          return Card(
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  gadget.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                gadget.name,
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                gadget.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EncyclopediaEntryPage(gadget: gadget),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
