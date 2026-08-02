import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

const _accent = Color(0xFF6C5CE7);

class Day61ConnectivityPlus extends StatefulWidget {
  const Day61ConnectivityPlus({super.key});

  @override
  State<Day61ConnectivityPlus> createState() => _Day61ConnectivityPlusState();
}

class _Day61ConnectivityPlusState extends State<Day61ConnectivityPlus> {
  final _connectivity = Connectivity();

  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  String _connection = 'Unknown';
  IconData _icon = Icons.help_outline_rounded;
  Color _color = Colors.grey;

  @override
  void initState() {
    super.initState();

    _checkConnection();

    _subscription = _connectivity.onConnectivityChanged.listen(
      _updateConnection,
    );
  }

  Future<void> _checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnection(result);
  }

  void _updateConnection(List<ConnectivityResult> result) {
    final hasInternet = !result.contains(ConnectivityResult.none);

    if (hasInternet) {
      if (result.contains(ConnectivityResult.wifi)) {
        _connection = 'Wi-Fi';
        _icon = Icons.wifi_rounded;
      } else if (result.contains(ConnectivityResult.mobile)) {
        _connection = 'Mobile Data';
        _icon = Icons.network_cell_rounded;
      } else if (result.contains(ConnectivityResult.ethernet)) {
        _connection = 'Ethernet';
        _icon = Icons.settings_ethernet_rounded;
      } else {
        _connection = 'Connected';
        _icon = Icons.public_rounded;
      }

      _color = Colors.green;

      _showNotification(
        'Connected',
        'Internet connection is available.',
        Colors.green,
        Icons.check_circle_rounded,
      );
    } else {
      _connection = 'Offline';
      _icon = Icons.wifi_off_rounded;
      _color = Colors.red;

      _showNotification(
        'Disconnected',
        'No internet connection.',
        Colors.red,
        Icons.error_outline_rounded,
      );
    }

    if (mounted) setState(() {});
  }

  void _showNotification(
    String title,
    String message,
    Color color,
    IconData icon,
  ) {
    Flushbar(
      title: title,
      message: message,
      icon: Icon(icon, color: Colors.white),
      duration: const Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      backgroundColor: color,
    ).show(context);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 61 - Connectivity Plus',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .05),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Text(
                'connectivity_plus detects network connectivity changes such as Wi-Fi, mobile data, ethernet, or offline status. It can also listen for connection changes in real time.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const Spacer(),

            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [_color, _color.withValues(alpha: .7)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: _color.withValues(alpha: .25),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_icon, color: Colors.white, size: 70),
                  const SizedBox(height: 18),
                  Text(
                    _connection,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: _accent),
              onPressed: _checkConnection,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Check Connection'),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
