import 'package:flutter/material.dart';
import 'package:package_of_the_day/features/day39_shared_preferences/page/preferences_page.dart';

const _accent = Color(0xFF6C5CE7);

class Day39SharedPreferences extends StatefulWidget {
  const Day39SharedPreferences({super.key});

  @override
  State<Day39SharedPreferences> createState() => _Day39SharedPreferencesState();
}

class _Day39SharedPreferencesState extends State<Day39SharedPreferences> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();

  bool _darkMode = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _continue() {
    final name = _nameController.text.trim();
    final age = int.tryParse(_ageController.text.trim());
    final height = double.tryParse(_heightController.text.trim());

    if (name.isEmpty || age == null || height == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PreferencesPage(
          name: name,
          age: age,
          height: height,
          darkMode: _darkMode,
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Day 39 · Shared Preferences')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Shared Preferences stores small pieces of data such as Strings, ints, doubles and bools. The data remains available even after the app restarts.',
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5),
              ),
            ),

            const SizedBox(height: 25),

            _field(controller: _nameController, label: 'Name'),

            const SizedBox(height: 15),

            _field(
              controller: _ageController,
              label: 'Age',
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 15),

            _field(
              controller: _heightController,
              label: 'Height (ft)',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            const SizedBox(height: 10),

            SwitchListTile(
              value: _darkMode,
              activeThumbColor: _accent,
              title: const Text('Dark Mode'),
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _continue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
