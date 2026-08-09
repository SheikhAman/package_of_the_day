import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

const _accent = Color(0xFF6366F1);

class Day83Uuid extends StatefulWidget {
  const Day83Uuid({super.key});

  @override
  State<Day83Uuid> createState() => _Day83UuidState();
}

class _Day83UuidState extends State<Day83Uuid> {
  final _uuid = const Uuid();
  String _v1 = '';
  String _v4 = '';
  String _v5 = '';

  @override
  void initState() {
    super.initState();
    _generateIds();
  }

  void _generateIds() {
    setState(() {
      _v1 = _uuid.v1(); // Time-based
      _v4 = _uuid.v4(); // Random

      // FIX: Use Namespace.url instead of Uuid.NAMESPACE_URL
      _v5 = _uuid.v5(Namespace.url.value, 'www.google.com');
    });
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: _accent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 83 - UUID Generator',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info Card ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _accent.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: _accent,
                    child: Icon(Icons.fingerprint_rounded, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'The uuid package generates RFC4122 universally unique identifiers. Essential for database keys and unique session IDs.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            _IdTile(
              label: 'V4 (RANDOM - RECOMMENDED)',
              value: _v4,
              onCopy: () => _copyToClipboard(_v4, 'UUID v4'),
            ),
            _IdTile(
              label: 'V1 (TIME-BASED)',
              value: _v1,
              onCopy: () => _copyToClipboard(_v1, 'UUID v1'),
            ),
            _IdTile(
              label: 'V5 (NAME-BASED: google.com)',
              value: _v5,
              onCopy: () => _copyToClipboard(_v5, 'UUID v5'),
            ),

            const SizedBox(height: 32),

            ElevatedButton.icon(
              onPressed: _generateIds,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('GENERATE NEW IDS'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IdTile extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onCopy;

  const _IdTile({
    required this.label,
    required this.value,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Colors.black38,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: onCopy,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        color: _accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.copy_rounded,
                    size: 18,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
