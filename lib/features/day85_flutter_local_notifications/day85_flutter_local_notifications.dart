import 'package:flutter/material.dart';
import 'services/local_notification_service.dart';
import 'pages/notification_payload_page.dart';

/*
  HOW TO USE THIS PACKAGE (ANDROID SETUP):
  ---------------------------------------
  To make notifications work on modern Android devices, follow these 3 steps:

  STEP 1: Update 'android/app/build.gradle.kts'
  - Inside 'compileOptions', set: isCoreLibraryDesugaringEnabled = true
  - At the very bottom, add:
    dependencies {
       coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    }
  (Why? This allows older Android versions to understand modern Java time logic).

  STEP 2: Update 'android/app/src/main/AndroidManifest.xml'
  - Add these permissions inside the <manifest> tag:
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
    <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />

  - Add these receivers inside the <application> tag:
    <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
    <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
        <intent-filter>
            <action android:name="android.intent.action.BOOT_COMPLETED"/>
        </intent-filter>
    </receiver>

  STEP 3: Handle Android 13+ Permissions
  - Always call 'LocalNotificationService.requestPermissions()' when the app starts.
  - Use 'AndroidScheduleMode.inexactAllowWhileIdle' for scheduled alerts to
    prevent crashes related to strict battery optimization rules.
*/

const _accent = Color(0xFF6366F1);

class Day85FlutterLocalNotifications extends StatefulWidget {
  const Day85FlutterLocalNotifications({super.key});

  @override
  State<Day85FlutterLocalNotifications> createState() =>
      _Day85FlutterLocalNotificationsState();
}

class _Day85FlutterLocalNotificationsState
    extends State<Day85FlutterLocalNotifications> {
  @override
  void initState() {
    super.initState();
    // 1. Initialize the service (including timezone support)
    LocalNotificationService.init(initScheduled: true);

    // ADD THIS: Request permission when the page opens
    LocalNotificationService.requestPermissions();

    // 2. Listen to user interaction with notifications
    _listenToPayload();
  }

  /// Sets up a listener for the RxDart stream.
  /// When a user taps a notification, they are redirected to the detail page.
  void _listenToPayload() {
    LocalNotificationService.payloadStream.listen((payload) {
      if (!mounted) return;
      if (payload != null && payload.isNotEmpty) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NotificationPayloadPage(payload: payload),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 85 - Local Notifications',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info Card (Consistent UI) ──────────────────────────
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
              child: const Text(
                'Schedule and display system notifications to engage users even '
                'when the app is in the background. Essential for reminders and alerts.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),

            const Spacer(),
            const Center(
              child: Icon(
                Icons.notifications_active_outlined,
                size: 100,
                color: _accent,
              ),
            ),
            const Spacer(),

            // ── Interactive Buttons ───────────────────────────────
            _NotifyButton(
              label: 'Simple Notification',
              icon: Icons.notifications_none_rounded,
              color: Colors.black87,
              onTap: () => LocalNotificationService.showNotification(
                id: 0,
                title: 'Hello Developer! 🚀',
                body: 'This is a high-priority local notification.',
                payload: 'Data: Simple Notification',
              ),
            ),
            const SizedBox(height: 12),
            _NotifyButton(
              label: 'Schedule (5 Seconds)',
              icon: Icons.timer_outlined,
              color: _accent,
              onTap: () {
                LocalNotificationService.showScheduledNotification(
                  id: 1,
                  title: 'Timed Alert ⏰',
                  body: 'This was scheduled 5 seconds ago.',
                  payload: 'Data: Scheduled Notification',
                  scheduledDate: DateTime.now().add(const Duration(seconds: 5)),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Notification scheduled!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _NotifyButton(
              label: 'Clear All Notifications',
              icon: Icons.notifications_off_outlined,
              color: Colors.redAccent,
              onTap: () {
                LocalNotificationService.cancelAll();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All notifications cleared'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// A private helper widget for buttons to keep the main tree clean.
class _NotifyButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _NotifyButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
    );
  }
}
