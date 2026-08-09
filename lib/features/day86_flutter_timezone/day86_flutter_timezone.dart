import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

const _accent = Color(0xFF6366F1);

class Day86FlutterTimezone extends StatefulWidget {
  const Day86FlutterTimezone({super.key});

  @override
  State<Day86FlutterTimezone> createState() => _Day86FlutterTimezoneState();
}

class _Day86FlutterTimezoneState extends State<Day86FlutterTimezone> {
  String _localTimezone = 'Detecting...';
  List<String> _allTimezones = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTimezoneData();
  }

  /// Fetches the local device timezone and the full list of available timezones.
  Future<void> _fetchTimezoneData() async {
    setState(() => _isLoading = true);
    try {
      // 1. Get the specific timezone ID of the device (returns TimezoneInfo)
      final TimezoneInfo currentTimezoneInfo =
          await FlutterTimezone.getLocalTimezone();
      final String currentTimezone = currentTimezoneInfo.identifier;

      // 2. Get all valid timezone IDs supported by the system (returns List<TimezoneInfo>)
      final List<TimezoneInfo> availableTimezonesInfo =
          await FlutterTimezone.getAvailableTimezones();

      // Convert the list of TimezoneInfo to a list of Strings (identifiers)
      final List<String> availableTimezones = availableTimezonesInfo
          .map((info) => info.identifier)
          .toList();

      availableTimezones.sort();

      setState(() {
        _localTimezone = currentTimezone;
        _allTimezones = availableTimezones;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _localTimezone = 'Error detecting timezone';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 86 - Flutter Timezone',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
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
              child: const Text(
                'This package detects the device\'s native timezone. It is '
                'the modern, maintained successor to flutter_native_timezone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ── Local Timezone Hero ────────────────────────────────
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_accent, Color(0xFF818CF8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: _accent.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.public_rounded,
                    color: Colors.white70,
                    size: 40,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'CURRENT LOCATION',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _localTimezone,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ── List Header ────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'GLOBAL TIMEZONES',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.black38,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  '${_allTimezones.length} Total',
                  style: const TextStyle(
                    fontSize: 11,
                    color: _accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Timezone List ──────────────────────────────────────
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: _accent),
                    )
                  : ListView.separated(
                      itemCount: _allTimezones.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final tz = _allTimezones[index];
                        final isCurrent = tz == _localTimezone;

                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isCurrent
                                  ? _accent
                                  : Colors.black.withValues(alpha: 0.05),
                            ),
                          ),
                          child: ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              radius: 14,
                              backgroundColor: isCurrent
                                  ? _accent
                                  : Colors.grey.shade100,
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isCurrent
                                      ? Colors.white
                                      : Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              tz,
                              style: TextStyle(
                                fontWeight: isCurrent
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isCurrent ? _accent : Colors.black87,
                              ),
                            ),
                            trailing: isCurrent
                                ? const Icon(
                                    Icons.check_circle_rounded,
                                    color: _accent,
                                    size: 20,
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchTimezoneData,
        backgroundColor: Colors.black87,
        child: const Icon(Icons.refresh_rounded, color: Colors.white),
      ),
    );
  }
}
