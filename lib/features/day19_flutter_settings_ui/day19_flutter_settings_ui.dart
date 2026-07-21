import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

const _accent = Color(0xFF6C5CE7);

class Day19FlutterSettingsUi extends StatefulWidget {
  const Day19FlutterSettingsUi({super.key});

  @override
  State<Day19FlutterSettingsUi> createState() => _Day19FlutterSettingsUiState();
}

class _Day19FlutterSettingsUiState extends State<Day19FlutterSettingsUi> {
  bool _lockInBackground = true;
  bool _useFingerprint = false;

  void _showSnack(String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening "$label"...'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 19 · Settings UI',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // ── Info card ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'flutter_settings_ui builds native-feeling settings screens '
                '— sections, tiles, and switches — out of the box.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),
          ),

          Expanded(
            child: SettingsList(
              sections: [
                SettingsSection(
                  title: const Text('Common'),
                  tiles: [
                    SettingsTile(
                      title: const Text('Language'),
                      description: const Text('English'),
                      leading: const Icon(Icons.language, color: _accent),
                      onPressed: (context) => _showSnack('Language'),
                    ),
                    SettingsTile(
                      title: const Text('Environment'),
                      description: const Text('Production'),
                      leading: const Icon(Icons.cloud_queue, color: _accent),
                      onPressed: (context) => _showSnack('Environment'),
                    ),
                  ],
                ),
                SettingsSection(
                  title: const Text('Account'),
                  tiles: [
                    SettingsTile(
                      title: const Text('Phone number'),
                      leading: const Icon(Icons.phone, color: _accent),
                      onPressed: (context) => _showSnack('Phone number'),
                    ),
                    SettingsTile(
                      title: const Text('Email'),
                      leading: const Icon(Icons.email, color: _accent),
                      onPressed: (context) => _showSnack('Email'),
                    ),
                    SettingsTile(
                      title: const Text('Sign out'),
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.redAccent,
                      ),
                      onPressed: (context) => _showSnack('Sign out'),
                    ),
                  ],
                ),
                SettingsSection(
                  title: const Text('Security'),
                  tiles: [
                    SettingsTile.switchTile(
                      title: const Text('Lock app in background'),
                      leading: const Icon(Icons.phonelink_lock, color: _accent),
                      initialValue: _lockInBackground,
                      onToggle: (newValue) =>
                          setState(() => _lockInBackground = newValue),
                    ),
                    SettingsTile.switchTile(
                      title: const Text('Use fingerprint'),
                      leading: const Icon(Icons.fingerprint, color: _accent),
                      initialValue: _useFingerprint,
                      onToggle: (newValue) =>
                          setState(() => _useFingerprint = newValue),
                    ),
                    // "Change password" is an action, not a toggle — kept as
                    // a regular tile instead of a switch (the original had
                    // this as switchTile, which doesn't make sense for it).
                    SettingsTile(
                      title: const Text('Change password'),
                      leading: const Icon(Icons.lock, color: _accent),
                      onPressed: (context) => _showSnack('Change password'),
                    ),
                  ],
                ),
                SettingsSection(
                  title: const Text('Misc'),
                  tiles: [
                    SettingsTile(
                      title: const Text('Terms of Service'),
                      leading: const Icon(Icons.file_copy, color: _accent),
                      onPressed: (context) => _showSnack('Terms of Service'),
                    ),
                    SettingsTile(
                      title: const Text('Open source licenses'),
                      leading: const Icon(
                        Icons.open_with_sharp,
                        color: _accent,
                      ),
                      onPressed: (context) =>
                          _showSnack('Open source licenses'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
