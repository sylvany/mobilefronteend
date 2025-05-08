import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.library_music, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              "Your Music Library",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Songs, albums, and playlists you've saved will appear here.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingButtons(),
    );
  }

  Widget _buildFloatingButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.extended(
          onPressed: () {
            print("Add Playlist button pressed");
          },
          icon: const Icon(Icons.playlist_add, color: Colors.white),
          label: Text(
            "Add Playlist",
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF4860FF),
        ),
        const SizedBox(height: 16),
        FloatingActionButton.extended(
          onPressed: () {
            print("Add Song button pressed");
          },
          icon: const Icon(Icons.library_add, color: Colors.white),
          label: Text(
            "Add Song",
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF4860FF),
        ),
      ],
    );
  }
}
