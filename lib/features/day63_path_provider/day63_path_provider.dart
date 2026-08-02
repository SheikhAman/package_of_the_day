import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

const _accent = Color(0xFF6C5CE7);

class Day63PathProvider extends StatefulWidget {
  const Day63PathProvider({super.key});

  @override
  State<Day63PathProvider> createState() => _Day63PathProviderState();
}

class _Day63PathProviderState extends State<Day63PathProvider> {
  String? _temporaryPath;
  String? _documentsPath;
  String? _savedText;

  Future<void> _loadDirectories() async {
    final tempDir = await getTemporaryDirectory();
    final docDir = await getApplicationDocumentsDirectory();

    setState(() {
      _temporaryPath = tempDir.path;
      _documentsPath = docDir.path;
    });
  }

  Future<void> _saveFile() async {
    final directory = await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/package_of_the_day.txt');

    await file.writeAsString('Hello from Flutter!\nSaved using path_provider.');

    setState(() {
      _savedText = 'File saved successfully!';
    });
  }

  Future<void> _readFile() async {
    final directory = await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/package_of_the_day.txt');

    if (await file.exists()) {
      final text = await file.readAsString();

      setState(() {
        _savedText = text;
      });
    } else {
      setState(() {
        _savedText = 'No file found.';
      });
    }
  }

  Widget _infoCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Text(
        'path_provider provides commonly used storage locations such as temporary and application document directories. It is commonly used for saving files, images, downloads, and app data.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, height: 1.6, color: Colors.black54),
      ),
    );
  }

  Widget _pathTile({
    required String title,
    required String? value,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _accent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value ?? '$title not loaded',
              style: const TextStyle(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String title, IconData icon, VoidCallback onPressed) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: _accent,
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 63 - Path Provider',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _infoCard(),

            const SizedBox(height: 24),

            _actionButton(
              'Load Storage Paths',
              Icons.folder_open_rounded,
              _loadDirectories,
            ),

            _pathTile(
              title: 'Temporary Directory',
              value: _temporaryPath,
              icon: Icons.folder_copy_outlined,
            ),

            _pathTile(
              title: 'Documents Directory',
              value: _documentsPath,
              icon: Icons.folder_rounded,
            ),

            const SizedBox(height: 24),

            _actionButton('Save File', Icons.save_outlined, _saveFile),

            const SizedBox(height: 12),

            _actionButton('Read File', Icons.description_outlined, _readFile),

            if (_savedText != null) ...[
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(_savedText!, style: const TextStyle(height: 1.6)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
