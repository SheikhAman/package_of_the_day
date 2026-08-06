import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

const _accent = Color(0xFF6C5CE7);

class Day71FilePicker extends StatefulWidget {
  const Day71FilePicker({super.key});

  @override
  State<Day71FilePicker> createState() => _Day71FilePickerState();
}

class _Day71FilePickerState extends State<Day71FilePicker> {
  String? _fileName;
  String? _fileExtension;
  double? _fileSize;
  String? _filePath;

  Future<void> pickFile() async {
    final result = await FilePicker.pickFiles();

    // User cancelled picker
    if (result == null) return;

    final file = result.files.first;

    setState(() {
      _fileName = file.name;
      _fileExtension = file.extension ?? 'Unknown';
      _fileSize = file.size / 1024;
      _filePath = file.path;
    });

    debugPrint('Name: ${file.name}');
    debugPrint('Size: ${file.size}');
    debugPrint('Extension: ${file.extension}');
    debugPrint('Path: ${file.path}');
  }

  Future<void> openSelectedFile() async {
    if (_filePath == null) return;

    await OpenFile.open(_filePath);
  }

  void reset() {
    setState(() {
      _fileName = null;
      _fileExtension = null;
      _fileSize = null;
      _filePath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 71 - File Picker',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(18),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                children: [
                  const Icon(
                    Icons.insert_drive_file_rounded,
                    size: 60,
                    color: _accent,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'File Name\n${_fileName ?? "No file selected"}',
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Size\n${_fileSize?.toStringAsFixed(2) ?? "-"} KB',
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Extension\n.${_fileExtension ?? "-"}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            FilledButton.icon(
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: _accent,
              ),

              onPressed: pickFile,

              icon: const Icon(Icons.folder_open),

              label: const Text('Pick File'),
            ),

            const SizedBox(height: 15),

            FilledButton.icon(
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),

              onPressed: openSelectedFile,

              icon: const Icon(Icons.open_in_new),

              label: const Text('Open File'),
            ),

            const SizedBox(height: 15),

            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),

              onPressed: reset,

              icon: const Icon(Icons.refresh),

              label: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
