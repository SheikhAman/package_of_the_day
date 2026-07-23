import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

const _accent = Color(0xFF6C5CE7);

class Day32ImagePicker extends StatefulWidget {
  const Day32ImagePicker({super.key});

  @override
  State<Day32ImagePicker> createState() => _Day32ImagePickerState();
}

class _Day32ImagePickerState extends State<Day32ImagePicker> {
  Uint8List? _imageBytes;
  bool _isLoading = false;

  // The original used File(image.path) + Image.file(...), which throws on
  // Flutter web (there's no real filesystem there — File is unavailable).
  // Reading the picked image as bytes and displaying it with Image.memory
  // works identically on mobile, desktop, and web.
  Future<void> _pickImage(ImageSource source) async {
    setState(() => _isLoading = true);
    try {
      final picked = await ImagePicker().pickImage(source: source);
      if (picked == null) return; // user cancelled — not an error

      final bytes = await picked.readAsBytes();
      setState(() => _imageBytes = bytes);
    } on PlatformException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Couldn\'t access the camera/gallery: ${e.message}'),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 32 - Image Picker',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info card ──────────────────────────────────────────
            Container(
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
                'image_picker lets users choose a photo from their gallery '
                'or take a new one with the camera — a near-universal '
                'building block for profile pictures and uploads.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const Spacer(),

            // ── Preview ────────────────────────────────────────────
            Center(
              child: Container(
                width: 160,
                height: 160,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _accent.withValues(alpha: 0.1),
                  border: Border.all(
                    color: _accent.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: _accent),
                      )
                    : _imageBytes != null
                    ? Image.memory(_imageBytes!, fit: BoxFit.cover)
                    : const Icon(
                        Icons.person_rounded,
                        color: _accent,
                        size: 72,
                      ),
              ),
            ),

            const Spacer(),

            // ── Buttons ────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _PickButton(
                    icon: Icons.image_outlined,
                    label: 'Gallery',
                    onTap: () => _pickImage(ImageSource.gallery),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _PickButton(
                    icon: Icons.camera_alt_outlined,
                    label: 'Camera',
                    onTap: () => _pickImage(ImageSource.camera),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PickButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PickButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            children: [
              Icon(icon, color: _accent, size: 24),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
