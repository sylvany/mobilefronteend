import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'library_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _playlists = [
    {"title": "Top Hits", "image": "assets/top.jpg"},
    {"title": "Chill Vibes", "image": "assets/chill.jpg"},
    {"title": "Workout Mix", "image": "assets/workout.jpg"},
    {"title": "Focus Beats", "image": "assets/focus.jpg"},
    {"title": "Jazz Lounge", "image": "assets/jazz.jpg"},
    {"title": "EDM Party", "image": "assets/edm.jpg"},
    {"title": "Classical", "image": "assets/classical.jpg"},
    {"title": "R&B Soul", "image": "assets/rnb.jpg"},
  ];

  String _searchQuery = "";
  int _currentIndex = 0;

  // Selection mode for deleting playlists
  bool _isSelectionMode = false;
  final Set<int> _selectedPlaylists = {};

  final List<Widget> _pages = [
    Center(child: Text("Home Screen Placeholder")),
    Center(child: Text("Search Screen Placeholder")),
    const LibraryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredPlaylists =
        _playlists
            .where(
              (playlist) => playlist["title"]!.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
            )
            .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body:
          _currentIndex == 0
              ? _buildBody(filteredPlaylists)
              : _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title:
          _isSelectionMode
              ? Text(
                "${_selectedPlaylists.length} Selected",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: const Color(0xFF4860FF),
                ),
              )
              : Row(
                children: [
                  Image.asset('assets/Logo2.png', width: 40, height: 40),
                  const SizedBox(width: 12),
                  Text(
                    "Tak Tung",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: const Color(0xFF4860FF),
                    ),
                  ),
                ],
              ),
      actions:
          _isSelectionMode
              ? [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: _deleteSelectedPlaylists,
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF4860FF)),
                  onPressed: () {
                    setState(() {
                      _isSelectionMode = false;
                      _selectedPlaylists.clear();
                    });
                  },
                ),
              ]
              : [
                IconButton(
                  icon: const Icon(Icons.settings, color: Color(0xFF4860FF)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ],
    );
  }

  Widget _buildBody(List<Map<String, String>> playlists) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchField(),
          const SizedBox(height: 24),
          Text(
            "Your Playlists",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildPlaylistGrid(playlists),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      cursorColor: const Color(0xFF4860FF),
      style: GoogleFonts.poppins(color: Colors.black),
      onChanged: (value) => setState(() => _searchQuery = value),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        hintText: "Search playlists...",
        hintStyle: GoogleFonts.poppins(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Color(0xFF4860FF)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4860FF)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
      ),
    );
  }

  Widget _buildPlaylistGrid(List<Map<String, String>> playlists) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.70,
        ),
        itemCount: playlists.length,
        itemBuilder:
            (context, index) => _buildPlaylistTile(playlists[index], index),
      ),
    );
  }

  Widget _buildPlaylistTile(Map<String, String> playlist, int index) {
    final isSelected = _selectedPlaylists.contains(index);

    return GestureDetector(
      onLongPress: () {
        setState(() {
          _isSelectionMode = true;
          _selectedPlaylists.add(index);
        });
      },
      onTap: () {
        if (_isSelectionMode) {
          setState(() {
            if (isSelected) {
              _selectedPlaylists.remove(index);
            } else {
              _selectedPlaylists.add(index);
            }
          });
        }
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(playlist["image"]!, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      playlist["title"]!,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (_isSelectionMode)
                    Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _selectedPlaylists.add(index);
                          } else {
                            _selectedPlaylists.remove(index);
                          }
                        });
                      },
                      activeColor: const Color(0xFF4860FF),
                    ),
                ],
              ),
              Text(
                "12 songs",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _deleteSelectedPlaylists() {
    setState(() {
      _playlists.removeWhere(
        (playlist) => _selectedPlaylists.contains(_playlists.indexOf(playlist)),
      );
      _selectedPlaylists.clear();
      _isSelectionMode = false;
    });
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF4860FF),
      unselectedItemColor: Colors.grey[600],
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      elevation: 4,
      showUnselectedLabels: true,
      selectedLabelStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      iconSize: 26,
      onTap: (index) => setState(() => _currentIndex = index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music_outlined),
          activeIcon: Icon(Icons.library_music),
          label: "Library",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          activeIcon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}
