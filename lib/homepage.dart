// Flutter code for JukeBreeze homepage UI with described features and added comments, mood pills, and dark theme toggle
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(JukeBreezeApp());
}

class JukeBreezeApp extends StatefulWidget {
  @override
  _JukeBreezeAppState createState() => _JukeBreezeAppState();
}

class _JukeBreezeAppState extends State<JukeBreezeApp> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: JukeBreezeHomePage(
        isDarkTheme: isDarkTheme,
        onThemeChanged: (value) => setState(() => isDarkTheme = value),
      ),
    );
  }
}

class JukeBreezeHomePage extends StatefulWidget {
  final bool isDarkTheme;
  final ValueChanged<bool> onThemeChanged;

  JukeBreezeHomePage({required this.isDarkTheme, required this.onThemeChanged});

  @override
  _JukeBreezeHomePageState createState() => _JukeBreezeHomePageState();
}

class _JukeBreezeHomePageState extends State<JukeBreezeHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String greeting = '';

  @override
  void initState() {
    super.initState();
    _setGreeting();
  }

  void _setGreeting() {
    final hour = DateTime.now().hour;
    setState(() {
      if (hour < 12) {
        greeting = 'Good Morning';
      } else if (hour < 18) {
        greeting = 'Good Afternoon';
      } else {
        greeting = 'Good Evening';
      }
    });
  }

  // Dynamic greeting message
  Widget _buildGreeting() {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(seconds: 2),
      child: Text(
        'Hello, $greeting, Alex',
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Search bar with mic icon
  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for songs or artists...',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Icon(Icons.mic, color: Colors.white70),
        ],
      ),
    );
  }

  // Horizontal list of recommended songs with pulse on currently playing
  Widget _buildRecommendations() {
    List<Map<String, String>> songs = [
      {'title': 'Song A', 'artist': 'Artist 1', 'cover': 'assets/cover1.jpg'},
      {'title': 'Song B', 'artist': 'Artist 2', 'cover': 'assets/cover2.jpg'},
      {'title': 'Song C', 'artist': 'Artist 3', 'cover': 'assets/cover3.jpg'},
      {'title': 'Song D', 'artist': 'Artist 4', 'cover': 'assets/cover4.jpg'},
      {'title': 'Song E', 'artist': 'Artist 5', 'cover': 'assets/cover5.jpg'},
      {'title': 'Song F', 'artist': 'Artist 6', 'cover': 'assets/cover6.jpg'},
    ];
    String currentSong = 'Song C';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Recommendations', style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
        SizedBox(height: 10),
        Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return Stack(
                children: [
                  Container(
                    width: 140,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(song['cover']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black45],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(song['title']!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text(song['artist']!, style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ),
                  if (song['title'] == currentSong)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.cyanAccent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyanAccent.withOpacity(0.6),
                              blurRadius: 6,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              );
            },
          ),
        )
      ],
    );
  }

  // Quick access grid with icons and labels
  Widget _buildQuickAccess() {
    List<Map<String, dynamic>> cards = [
      {'icon': Icons.favorite, 'label': 'Favorites'},
      {'icon': Icons.music_note, 'label': 'My Playlists'},
      {'icon': Icons.access_time, 'label': 'Recently Played'},
      {'icon': Icons.radio, 'label': 'Radio'},
    ];

    return Padding(
      padding: EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: cards.map((card) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {},
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF71A6D2), Color(0xFFB0E0E6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                      ),
                      child: Icon(card['icon'], color: Colors.white, size: 28),
                    ),
                    SizedBox(height: 8),
                    Text(card['label'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Browse by Mood section with scrollable pills
  Widget _buildBrowseByMood() {
    final moods = ['Chill', 'Energetic', 'Focus', 'Happy', 'Sad'];
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 16, top: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: moods.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                moods[index],
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Colors.blue.shade900,
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50),
            children: [
              Center(child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24))),
              ListTile(leading: Icon(Icons.settings, color: Colors.white), title: Text('Settings', style: TextStyle(color: Colors.white))),
              ListTile(leading: Icon(Icons.feedback, color: Colors.white), title: Text('Feedback', style: TextStyle(color: Colors.white))),
              ListTile(leading: Icon(Icons.info, color: Colors.white), title: Text('About Us', style: TextStyle(color: Colors.white))),
              SwitchListTile(
                value: widget.isDarkTheme,
                onChanged: widget.onThemeChanged,
                title: Text('Dark Theme', style: TextStyle(color: Colors.white)),
                secondary: Icon(Icons.dark_mode, color: Colors.white),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4169E1), Color(0xFF000080)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                    Expanded(
                      child: Center(
                        child: Text('JukeBreeze', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(width: 48),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _buildGreeting(),
              ),
              _buildSearchBar(),
              Expanded(
                child: ListView(
                  children: [
                    _buildRecommendations(),
                    _buildQuickAccess(),
                    _buildBrowseByMood(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            color: Colors.black.withOpacity(0.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Now Playing: Song C', style: TextStyle(color: Colors.white)),
                    Text('Artist 3', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.pause, color: Colors.white), onPressed: () {}),
                    IconButton(icon: Icon(Icons.bedtime, color: Colors.white), onPressed: () {}),
                  ],
                )
              ],
            ),
          ),
          BottomNavigationBar(
            backgroundColor: Color(0xFF000080),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.music_note), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
          ),
        ],
      ),
    );
  }
}
