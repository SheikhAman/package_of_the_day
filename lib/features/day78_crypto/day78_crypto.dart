import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _accent = Color(0xFF6366F1); // Indigo accent

class Day78Crypto extends StatefulWidget {
  const Day78Crypto({super.key});

  @override
  State<Day78Crypto> createState() => _Day78CryptoState();
}

class _Day78CryptoState extends State<Day78Crypto> {
  final _controller = TextEditingController();

  // Optimized state: Store only the hashes we want to display
  String _sha1 = '';
  String _sha256 = '';
  String _sha512 = '';
  String _md5 = '';
  String _hmac = '';

  @override
  void initState() {
    super.initState();
    // One listener handles all conversions efficiently
    _controller.addListener(_generateHashes);
  }

  void _generateHashes() {
    final text = _controller.text;
    if (text.isEmpty) {
      setState(() {
        _sha1 = _sha256 = _sha512 = _md5 = _hmac = '';
      });
      return;
    }

    final bytes = utf8.encode(text);
    final key = utf8.encode('secret-key-123'); // Example key for HMAC

    setState(() {
      _sha1 = sha1.convert(bytes).toString();
      _sha256 = sha256.convert(bytes).toString();
      _sha512 = sha512.convert(bytes).toString();
      _md5 = md5.convert(bytes).toString();
      _hmac = Hmac(sha256, key).convert(bytes).toString();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 78 - Crypto',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info Card ──────────────────────────────────────────
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
                'The crypto package provides a set of cryptographic hash '
                'functions for Dart. Essential for hashing passwords, '
                'verifying file integrity, and secure data transmission.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Input Text',
                hintText: 'Type something to hash...',
                prefixIcon: const Icon(Icons.security_rounded, color: _accent),
                filled: true,
                fillColor: _accent.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            _HashResultTile(label: 'SHA-256 (Highly Secure)', value: _sha256),
            _HashResultTile(label: 'HMAC-SHA256 (Keyed)', value: _hmac),
            _HashResultTile(label: 'SHA-512', value: _sha512),
            _HashResultTile(label: 'SHA-1 (Legacy)', value: _sha1),
            _HashResultTile(label: 'MD5 (Not Recommended)', value: _md5),
          ],
        ),
      ),
    );
  }
}

class _HashResultTile extends StatelessWidget {
  final String label;
  final String value;

  const _HashResultTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: value.isEmpty
                ? null
                : () {
                    Clipboard.setData(ClipboardData(text: value));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$label copied to clipboard')),
                    );
                  },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
              ),
              child: Text(
                value.isEmpty ? 'Waiting for input...' : value,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: value.isEmpty ? Colors.black26 : _accent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
