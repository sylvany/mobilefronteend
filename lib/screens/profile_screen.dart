import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, size: 60, color: Color(0xFF4860FF)),
          ),
          const SizedBox(height: 16),
          Text(
            "Asep",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            "asep111@example.com",
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.edit_outlined, color: Color(0xFF4860FF)),
            title: Text("Edit Profile", style: GoogleFonts.poppins()),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              debugPrint("Edit Profile tapped");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications_outlined,
              color: Color(0xFF4860FF),
            ),
            title: Text("Notifications", style: GoogleFonts.poppins()),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              debugPrint("Notifications tapped");
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline, color: Color(0xFF4860FF)),
            title: Text("Privacy Settings", style: GoogleFonts.poppins()),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              debugPrint("Privacy Settings tapped");
            },
          ),
          const Spacer(),
          ElevatedButton.icon(
            icon: const Icon(Icons.logout, color: Colors.white),
            label: Text(
              "Log Out",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              textStyle: const TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              debugPrint("Log Out tapped");
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
