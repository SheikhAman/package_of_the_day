import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

const _accent = Color(0xFF6366F1); // Modern Indigo

class Day99PrettyQrCode extends StatefulWidget {
  const Day99PrettyQrCode({super.key});

  @override
  State<Day99PrettyQrCode> createState() => _Day99PrettyQrCodeState();
}

class _Day99PrettyQrCodeState extends State<Day99PrettyQrCode> {
  // The data that will be encoded into the QR code
  String _qrData = 'https://github.com/SheikhAman';
  bool _isRounded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 99 - Pretty QR Code',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
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
                    color: _accent.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Text(
                'Pretty QR Code is the modern successor to qr_flutter. '
                'It allows for professional "Squircle" style dots and high-quality rendering.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ── QR Display Area ────────────────────────────────────
            Center(
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.05),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 15,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: PrettyQrView.data(
                    data: _qrData,
                    decoration: PrettyQrDecoration(
                      shape: _isRounded
                          ? const PrettyQrSmoothSymbol(color: _accent)
                          : const PrettyQrSquaresSymbol(color: Colors.black87),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ── Controls Section ───────────────────────────────────
            const _SectionLabel(text: 'QR GENERATOR SETTINGS'),

            // 1. Content Input
            TextField(
              onChanged: (value) {
                setState(() {
                  // QR codes cannot be empty, so we provide a space if text is cleared
                  _qrData = value.isEmpty ? ' ' : value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter URL or Text',
                hintText: 'e.g. https://google.com',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.qr_code_2_rounded, color: _accent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 2. Toggle Style Switch
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Smooth "Squircle" Style',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Switch(
                    value: _isRounded,
                    onChanged: (val) => setState(() => _isRounded = val),
                    activeColor: _accent,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Stats indicator
            Center(
              child: Text(
                'Data: ${_qrData.length} characters encoded',
                style: const TextStyle(
                  color: Colors.black26,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Private helper widget for organized labeling
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: Colors.black38,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
