import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

const _accent = Color(0xFF6366F1);

class Day82PinCodeFields extends StatefulWidget {
  const Day82PinCodeFields({super.key});

  @override
  State<Day82PinCodeFields> createState() => _Day82PinCodeFieldsState();
}

class _Day82PinCodeFieldsState extends State<Day82PinCodeFields> {
  // In v9.4.0, use PinInputController
  final PinInputController _pinController = PinInputController();
  final String _correctPin = "123456";

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _verifyPin(String value) {
    if (value == _correctPin) {
      _pinController.clearError();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const _SuccessPage()),
      );
    } else {
      // Correct method name for v9.4.0 is triggerError()
      _pinController.triggerError();

      // If you want to clear the numbers so the user can re-type:
      // Note: .clear() also clears the error state, so we use a small delay
      // or just clear the text manually if you want the red error border to stay.
      _pinController.text = "";

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect PIN, please try again.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 82 - Pin Code Fields',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
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
                    child: Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Using pin_code_fields v9.4.0 - A modern, rewritten architecture for secure OTP entries.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),
            const Text(
              'Verification',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter the 6-digit code sent to your device\n(Hint: 123456)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black45,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 48),

            // MaterialPinField is the widget name in version 9.4.0
            MaterialPinField(
              length: 6,
              pinController: _pinController,
              keyboardType: TextInputType.number,
              theme: MaterialPinTheme(
                shape: MaterialPinShape.outlined,
                borderRadius: BorderRadius.circular(12),
                cellSize: const Size(46, 56),
                focusedBorderColor: _accent,
                borderColor: Colors.black12,
                fillColor: Colors.white,
                focusedFillColor: Colors.white,
                entryAnimation: MaterialPinAnimation.fade,
              ),
              onCompleted: _verifyPin,
              onChanged: (value) {
                if (_pinController.hasError) _pinController.clearError();
              },
            ),

            const SizedBox(height: 40),
            TextButton(
              onPressed: () => _pinController.clear(),
              child: const Text(
                'CLEAR CODE',
                style: TextStyle(
                  color: _accent,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessPage extends StatelessWidget {
  const _SuccessPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              size: 100,
              color: Colors.greenAccent,
            ),
            const SizedBox(height: 24),
            const Text(
              'Verified Successfully!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Day82PinCodeFields(),
                ),
              ),
              child: const Text('GO BACK'),
            ),
          ],
        ),
      ),
    );
  }
}
