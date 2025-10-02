// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../views/scan/Index.dart';
// import '../views/diy/diy_page.dart';
// import '../views/hub/hub_page.dart';
// import '../views/guide/encyclopedia_page.dart'; 

// class BasePage extends StatelessWidget {
//   final int currentIndex;
//   final Widget child;

//   const BasePage({
//     super.key,
//     required this.currentIndex,
//     required this.child,
//   });

//   void _onTap(BuildContext context, int index) {
//     if (index == currentIndex) return;

//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const TrashTechHome()),
//         );
//         break;
//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const DiyPage()),
//         );
//         break;
//       // --- CHANGE IS HERE ---
//       case 2:
//         Navigator.pushReplacement(
//           context,
//           // Navigate to the main list page, not the detail page
//           MaterialPageRoute(builder: (_) => EncyclopediaPage()),
//         );
//         break;
//       case 3:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const HubPage()),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: child,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         selectedItemColor: const Color(0xFF94CF96),
//         unselectedItemColor: Colors.grey,
//         selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//         unselectedLabelStyle: GoogleFonts.poppins(),
//         onTap: (index) => _onTap(context, index),
//         type: BottomNavigationBarType.fixed, // Added for consistent layout
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             activeIcon: Icon(Icons.home), // Optional: for a filled look
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.build_outlined),
//             activeIcon: Icon(Icons.build),
//             label: 'DIY',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.menu_book_outlined),
//             activeIcon: Icon(Icons.menu_book),
//             label: 'Encyclopedia',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.hub_outlined),
//             activeIcon: Icon(Icons.hub),
//             label: 'Hub',
//           ),
//         ],
//       ),
//     );
//   }
// }