import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

const _accent = Color(0xFF6C5CE7);

class Day41DeviceInfoPlus extends StatefulWidget {
  const Day41DeviceInfoPlus({super.key});

  @override
  State<Day41DeviceInfoPlus> createState() => _Day41DeviceInfoPlusState();
}

class _Day41DeviceInfoPlusState extends State<Day41DeviceInfoPlus> {
  bool _isLoading = true;
  final Map<String, String> _info = {};

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo(); // loads automatically — no need to tap a button first
  }

  Future<void> _loadDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final Map<String, String> result = {};

    try {
      if (kIsWeb) {
        final web = await deviceInfoPlugin.webBrowserInfo;
        result['Browser'] = web.browserName.name;
        result['Platform'] = web.platform ?? 'Unknown';
        result['User Agent'] = web.userAgent ?? 'Unknown';
      } else if (Platform.isAndroid) {
        final android = await deviceInfoPlugin.androidInfo;
        result['Model'] = android.model;
        result['Brand'] = android.brand;
        result['Android Version'] = android.version.release;
        result['SDK Int'] = android.version.sdkInt.toString();
        result['Is Physical Device'] = android.isPhysicalDevice.toString();
        result['Identifier'] = android.id;
      } else if (Platform.isIOS) {
        final ios = await deviceInfoPlugin.iosInfo;
        result['Model'] = ios.model;
        result['Name'] = ios.name;
        result['System Name'] = ios.systemName;
        result['System Version'] = ios.systemVersion;
        result['Is Physical Device'] = ios.isPhysicalDevice.toString();
        result['Identifier For Vendor'] = ios.identifierForVendor ?? 'Unknown';
      } else {
        result['Platform'] = 'Unsupported in this demo';
      }
    } catch (e) {
      result['Error'] = 'Could not read device info: $e';
    }

    if (!mounted) return;
    setState(() {
      _info.addAll(result);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 41 - Device Info Plus',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() {
              _isLoading = true;
              _info.clear();
              _loadDeviceInfo();
            }),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
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
                'device_info_plus reads platform-specific device details — '
                'model, OS version, whether it\'s a real device or a '
                'simulator/emulator, and more.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: _accent),
                    )
                  : ListView.separated(
                      itemCount: _info.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final entry = _info.entries.elementAt(index);
                        return _InfoRow(label: entry.key, value: entry.value);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
