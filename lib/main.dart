import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Assuming these are your page imports
import 'views/scan/index.dart';
import 'views/diy/diy_page.dart';
import 'views/guide/encyclopedia_page.dart';
import 'views/hub/hub_page.dart';
import 'login_page.dart';

// 🔹 Google Sign-In instance
final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

void main() {
  runApp(const TrashTechApp());
}

class TrashTechApp extends StatefulWidget {
  const TrashTechApp({super.key});

  @override
  State<TrashTechApp> createState() => _TrashTechAppState();
}

class _TrashTechAppState extends State<TrashTechApp> {
  ThemeMode _themeMode = ThemeMode.light;
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      if (mounted) { 
        setState(() {
          _currentUser = account;
        });
      }
    });
    _googleSignIn.signInSilently();
  }

  /// 🔹 Toggle Light/Dark theme
  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  /// 🔹 Logout handler
  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {
      
    }
    setState(() {
      _currentUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF94CF96);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrashTech',
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.black,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: primaryGreen,
          unselectedItemColor: Color(0xFF6A6A6A),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: primaryGreen,
          background: Colors.grey[900]!,
          surface: Colors.grey[850]!, 
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[800],
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[850], 
          selectedItemColor: Colors.green[300],
          unselectedItemColor: Colors.grey[400],
        ),
      ),
      themeMode: _themeMode,
      home: _currentUser == null
          ? LoginPage(
              onSignIn: (user) {
                setState(() => _currentUser = user);
              },
              onLocalSignIn: () {
                
              },
            )
          : MainLayout(
              onToggleTheme: _toggleTheme,
              isDarkMode: _themeMode == ThemeMode.dark,
              user: _currentUser,
              onSignOut: _handleSignOut,
            ),
    );
  }
}

class MainLayout extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;
  final GoogleSignInAccount? user;
  final Future<void> Function() onSignOut;

  const MainLayout({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
    required this.user,
    required this.onSignOut,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Your actual pages
    _pages = [
      const TrashTechHome(),
      const DiyPage(),
      EncyclopediaPage(),
      const HubPage(),
    ];
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TrashTech", 
        style: 
          GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: widget.onSignOut,
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build_outlined),
            activeIcon: Icon(Icons.build),
            label: 'DIY',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'Encyclopedia',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Hub',
          ),
        ],
      ),
    );
  }
}