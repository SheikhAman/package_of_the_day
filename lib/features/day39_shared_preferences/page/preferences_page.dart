import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _accent = Color(0xFF6C5CE7);

class PreferencesPage extends StatefulWidget {
  final String name;
  final int age;
  final double height;
  final bool darkMode;

  const PreferencesPage({
    super.key,
    required this.name,
    required this.age,
    required this.height,
    required this.darkMode,
  });

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  String? _name;
  int? _age;
  double? _height;
  bool? _darkMode;

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', widget.name);
    await prefs.setInt('age', widget.age);
    await prefs.setDouble('height', widget.height);
    await prefs.setBool('darkMode', widget.darkMode);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preferences saved successfully.')),
    );
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _name = prefs.getString('name');
      _age = prefs.getInt('age');
      _height = prefs.getDouble('height');
      _darkMode = prefs.getBool('darkMode');
    });

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Preferences loaded.')));
  }

  Future<void> _clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    setState(() {
      _name = null;
      _age = null;
      _height = null;
      _darkMode = null;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Preferences cleared.')));
  }

  Widget _infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Preferences')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _savePreferences,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Save Preferences'),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _loadPreferences,
                child: const Text('Load Preferences'),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _clearPreferences,
                style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Clear Preferences'),
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: _name == null
                    ? const Center(
                        child: Text(
                          'No saved preferences',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoTile("Name", _name!),
                          _infoTile("Age", "$_age"),
                          _infoTile(
                            "Height",
                            "${_height!.toStringAsFixed(2)} ft",
                          ),
                          _infoTile(
                            "Dark Mode",
                            _darkMode! ? "Enabled" : "Disabled",
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
