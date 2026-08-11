/*
  📝 BEGINNER'S GUIDE: ENABLING PERMISSIONS
  -----------------------------------------
  To make this package work, you MUST declare permissions in the native files.
  Dart code alone cannot "unlock" system features.

  🚀 STEP 1: ANDROID SETUP
  Path: android/app/src/main/AndroidManifest.xml
  Add these inside the <manifest> tag:

  <!-- Camera & Audio -->
  <uses-permission android:name="android.permission.CAMERA" />
  <uses-permission android:name="android.permission.RECORD_AUDIO" />

  <!-- Location (Fine and Coarse) -->
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

  <!-- Storage logic for Android 10 and below -->
  <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

  <!-- Modern Media access for Android 13+ (API 33) -->
  <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
  <uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
  <uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />

  🍎 STEP 2: iOS SETUP
  Path: ios/Runner/Info.plist
  Add these keys inside the <dict> tag:

  <key>NSCameraUsageDescription</key>
  <string>App needs access to camera for taking photos.</string>
  <key>NSMicrophoneUsageDescription</key>
  <string>App needs access to microphone for recording audio.</string>
  <key>NSLocationWhenInUseUsageDescription</key>
  <string>App needs location to show where you are.</string>
  <key>NSPhotoLibraryUsageDescription</key>
  <string>App needs access to photos to save/pick media.</string>

  💡 PRO TIP:
  This code uses 'WidgetsBindingObserver' to detect when you return from the
  system settings screen. This allows the UI to update the 'GRANTED' status
  instantly without needing to restart the app.
*/

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

const _accent = Color(0xFF6366F1);
const _bg = Color(0xFFF8FAFC);

class Day95PermissionHandler extends StatefulWidget {
  const Day95PermissionHandler({super.key});

  @override
  State<Day95PermissionHandler> createState() => _Day95PermissionHandlerState();
}

/// We use 'WidgetsBindingObserver' to listen to app lifecycle changes
class _Day95PermissionHandlerState extends State<Day95PermissionHandler>
    with WidgetsBindingObserver {
  Map<Permission, PermissionStatus> _statuses = {};

  @override
  void initState() {
    super.initState();
    // Register this class as a lifecycle observer
    WidgetsBinding.instance.addObserver(this);
    _refreshStatuses();
  }

  @override
  void dispose() {
    // Always unregister observers to prevent memory leaks
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Detects when the app comes back to the foreground (resumed)
  /// and automatically refreshes the permission UI.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshStatuses();
    }
  }

  /// Modern Android logic: Use 'Permission.photos' for Android 13+ media access
  Permission get _storagePermission {
    if (Platform.isAndroid) return Permission.photos;
    return Permission.storage;
  }

  Future<void> _refreshStatuses() async {
    final permissions = [
      Permission.camera,
      Permission.microphone,
      Permission.location,
      _storagePermission,
    ];

    Map<Permission, PermissionStatus> updated = {};
    for (var p in permissions) {
      updated[p] = await p.status;
    }

    if (mounted) setState(() => _statuses = updated);
  }

  Future<void> _handleRequest(Permission p) async {
    final status = await p.request();
    setState(() => _statuses[p] = status);

    // If denied permanently, guide user to settings
    if (status.isPermanentlyDenied) {
      _showSettingsDialog();
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Permission Required'),
        content: const Text(
          'Please enable access in your phone settings to continue using this feature.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: const Text(
              'OPEN SETTINGS',
              style: TextStyle(color: _accent, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text('Day 95 - Permissions'),
        actions: [
          IconButton(
            onPressed: _refreshStatuses,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoCard(),
            const SizedBox(height: 32),
            const Text(
              'ACCESS CONTROL',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.black38,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _PermissionTile(
              label: 'Camera',
              icon: Icons.camera_alt_outlined,
              status: _statuses[Permission.camera],
              onTap: () => _handleRequest(Permission.camera),
            ),
            _PermissionTile(
              label: 'Microphone',
              icon: Icons.mic_none_rounded,
              status: _statuses[Permission.microphone],
              onTap: () => _handleRequest(Permission.microphone),
            ),
            _PermissionTile(
              label: 'Location',
              icon: Icons.location_on_outlined,
              status: _statuses[Permission.location],
              onTap: () => _handleRequest(Permission.location),
            ),
            _PermissionTile(
              label: Platform.isAndroid ? 'Photos / Media' : 'Storage',
              icon: Icons.photo_library_outlined,
              status: _statuses[_storagePermission],
              onTap: () => _handleRequest(_storagePermission),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
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
      child: const Text(
        'UI now updates automatically when you return from System Settings, '
        'thanks to the WidgetsBindingObserver lifecycle listener.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, height: 1.5, color: Colors.black87),
      ),
    );
  }
}

class _PermissionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final PermissionStatus? status;
  final VoidCallback onTap;

  const _PermissionTile({
    required this.label,
    required this.icon,
    this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isGranted = status?.isGranted ?? false;
    final color = isGranted
        ? const Color(0xFF10B981)
        : (status?.isPermanentlyDenied ?? false
              ? Colors.redAccent
              : Colors.black45);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.1),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          status?.toString().split('.').last.toUpperCase() ?? 'CHECKING',
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Colors.black12,
        ),
      ),
    );
  }
}
