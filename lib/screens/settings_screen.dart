import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  final String theme;
  final String quality;
  final bool autoplay;
  final bool crossfade;
  final double crossfadeDuration;
  final bool explicitContent;
  final bool censorContent;
  final Function(String) onThemeChanged;
  final Function(String) onQualityChanged;
  final Function(bool) onAutoplayChanged;
  final Function(bool) onCrossfadeChanged;
  final Function(double) onCrossfadeDurationChanged;
  final Function(bool) onExplicitContentChanged;
  final Function(bool) onCensorContentChanged;

  const SettingsScreen({
    Key? key,
    required this.theme,
    required this.quality,
    required this.autoplay,
    required this.crossfade,
    required this.crossfadeDuration,
    required this.explicitContent,
    required this.censorContent,
    required this.onThemeChanged,
    required this.onQualityChanged,
    required this.onAutoplayChanged,
    required this.onCrossfadeChanged,
    required this.onCrossfadeDurationChanged,
    required this.onExplicitContentChanged,
    required this.onCensorContentChanged,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _theme;
  late String _quality;
  late bool _autoplay;
  late bool _crossfade;
  late double _crossfadeDuration;
  late bool _explicitContent;
  late bool _censorContent;
  String _language = "English";

  final List<Map<String, String>> _languages = [
    {"name": "English", "code": "en"},
    {"name": "Bahasa Indonesia", "code": "id"},
    {"name": "Français", "code": "fr"},
    {"name": "Português", "code": "pt"},
    {"name": "Español", "code": "es"},
    {"name": "中文", "code": "zh"},
    {"name": "日本語", "code": "jp"},
    {"name": "한국어", "code": "ko"},
  ];

  @override
  void initState() {
    super.initState();
    _theme = widget.theme;
    _quality = widget.quality;
    _autoplay = widget.autoplay;
    _crossfade = widget.crossfade;
    _crossfadeDuration = widget.crossfadeDuration;
    _explicitContent = widget.explicitContent;
    _censorContent = widget.censorContent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF4860FF)),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: const Color(0xFF4860FF),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // APPEARANCE SECTION
            _buildHeader("APPEARANCE"),
            _buildDropdown(
              title: "App Theme",
              subtitle: "Choose your preferred app theme",
              value: _theme,
              items: ["Light", "Dark", "Automatic"],
              onChanged: (value) {
                setState(() => _theme = value!);
                widget.onThemeChanged(value!);
              },
            ),

            const SizedBox(height: 24),

            // AUDIO SECTION
            _buildHeader("AUDIO"),
            _buildSubheader("Audio Quality"),
            _buildRadioOption("Low", "Low"),
            _buildRadioOption("Medium", "Medium"),
            _buildRadioOption("High", "High"),
            _buildCurrentSetting("Current Quality", _quality),

            const SizedBox(height: 24),
            _buildSubheader("Playback"),
            _buildSwitch(
              "Autoplay",
              "Automatically play the next song",
              _autoplay,
              (value) {
                setState(() => _autoplay = value);
                widget.onAutoplayChanged(value);
              },
            ),

            const SizedBox(height: 24),

            // LANGUAGE SECTION
            _buildHeader("LANGUAGE"),
            _buildDropdown(
              title: "App Language",
              subtitle: "Changes will be applied after restart",
              value: _language,
              items: _languages.map((e) => e["name"]!).toList(),
              onChanged: (value) => setState(() => _language = value!),
            ),

            const SizedBox(height: 24),

            // CROSSFADE SECTION
            _buildHeader("CROSSFADE"),
            _buildSwitch(
              "Enable Crossfade",
              "Smooth transition between songs",
              _crossfade,
              (value) {
                setState(() => _crossfade = value);
                widget.onCrossfadeChanged(value);
              },
            ),
            if (_crossfade) _buildSlider(),

            const SizedBox(height: 24),

            // CONTENT SECTION
            _buildHeader("CONTENT"),
            _buildSwitch(
              "Allow Explicit Content",
              "Explicit content can be played when turned on",
              _explicitContent,
              (value) {
                setState(() => _explicitContent = value);
                widget.onExplicitContentChanged(value);
              },
            ),
            _buildSwitch(
              "Censor Lyrics or Cover Art",
              "Censor explicit words in lyrics and inappropriate images",
              _censorContent,
              (value) {
                setState(() => _censorContent = value);
                widget.onCensorContentChanged(value);
              },
            ),

            const SizedBox(height: 24),

            // ABOUT SECTION
            _buildHeader("ABOUT"),
            _buildInfo("App Version", "1.2.3"),
            _buildInfo(
              "Developers",
              "Michael Andreas    |   Silvani Chayadi   |   Diky Diwa   |   Reno Kurniawan",
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: const Color(0xFF4860FF),
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildSubheader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: DropdownButton<String>(
                value: value,
                underline: Container(),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                dropdownColor: Colors.white,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFF4860FF),
                ),
                onChanged: onChanged,
                items:
                    items.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioOption(String title, String value) {
    return RadioListTile(
      title: Text(title, style: GoogleFonts.poppins(fontSize: 16)),
      value: value,
      groupValue: _quality,
      onChanged: (value) {
        setState(() => _quality = value!);
        widget.onQualityChanged(value!);
      },
      activeColor: const Color(0xFF4860FF),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title, style: GoogleFonts.poppins(fontSize: 16)),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF4860FF),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildCurrentSetting(String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: GoogleFonts.poppins(fontSize: 16)),
      trailing: Text(
        value,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: const Color(0xFF4860FF),
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Slider(
          value: _crossfadeDuration,
          min: 0,
          max: 12,
          divisions: 12,
          onChanged: (value) {
            setState(() => _crossfadeDuration = value);
            widget.onCrossfadeDurationChanged(value);
          },
          activeColor: const Color(0xFF4860FF),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1s",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
              ),
              Text(
                "12s",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfo(String title, String value, [bool isMultiLine = false]) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: GoogleFonts.poppins(fontSize: 16)),
      subtitle:
          isMultiLine
              ? Text(
                value,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
              )
              : null,
      trailing:
          !isMultiLine
              ? Text(
                value,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              )
              : null,
    );
  }
}
