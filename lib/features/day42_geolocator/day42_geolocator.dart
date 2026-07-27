import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

const _accent = Color(0xFF6C5CE7);

class Day42Geolocator extends StatefulWidget {
  const Day42Geolocator({super.key});

  @override
  State<Day42Geolocator> createState() => _Day42GeolocatorState();
}

class _Day42GeolocatorState extends State<Day42Geolocator> {
  double? _latitude;
  double? _longitude;
  String? _errorMessage;
  bool _isLoading = false;

  // The original wrapped `getCurrentPosition()` — an async function — in
  // `setState(() { getCurrentPosition(); })`. setState's callback runs
  // synchronously; it doesn't wait for the async work inside, so the
  // rebuild happened before latitude/longitude were ever set. Splitting
  // this into a proper async method that calls setState *after* each
  // await fixes that.
  Future<void> _getCurrentPosition() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage =
              'Location services are turned off. Enable them in device settings.';
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // The original requested permission but never checked the result
        // or proceeded afterward — the fetch simply never happened even
        // if the user tapped "Allow". Re-checking and continuing fixes it.
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = 'Location permission denied.';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage =
              'Permission permanently denied. Enable it from app settings.';
          _isLoading = false;
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
        ),
      );

      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Could not get location: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 42 · Geolocator',
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
                'geolocator reads the device\'s GPS coordinates, handling '
                'permission requests and location-services checks along '
                'the way.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const Spacer(),

            // ── Result / error ────────────────────────────────────
            if (_errorMessage != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
                ),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(fontSize: 13, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.location_on_rounded, color: _accent, size: 40),
                    const SizedBox(height: 16),
                    _CoordinateRow(
                      label: 'Latitude',
                      value: _latitude?.toStringAsFixed(6) ?? '—',
                    ),
                    const SizedBox(height: 10),
                    _CoordinateRow(
                      label: 'Longitude',
                      value: _longitude?.toStringAsFixed(6) ?? '—',
                    ),
                  ],
                ),
              ),

            const Spacer(),

            ElevatedButton.icon(
              onPressed: _isLoading ? null : _getCurrentPosition,
              icon: _isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.my_location_rounded, size: 18),
              label: Text(_isLoading ? 'Locating...' : 'Get Current Position'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.white,
                disabledBackgroundColor: _accent.withValues(alpha: 0.5),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoordinateRow extends StatelessWidget {
  final String label;
  final String value;

  const _CoordinateRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black45,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
