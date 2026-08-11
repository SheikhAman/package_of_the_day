import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

const _accent = Color(0xFF6366F1);

class Day93Skeletonizer extends StatefulWidget {
  const Day93Skeletonizer({super.key});

  @override
  State<Day93Skeletonizer> createState() => _Day93SkeletonizerState();
}

class _Day93SkeletonizerState extends State<Day93Skeletonizer> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  /// Simulates a network call to fetch data
  Future<void> _simulateLoading() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 93 - Skeletonizer',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: _simulateLoading,
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Simulate Reload',
          ),
        ],
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
                'Skeletonizer automatically transforms your real widgets into a loading skeleton. '
                'This eliminates the need to build separate, manual Shimmer layouts.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ── The Skeletonizer View ──────────────────────────────
            Expanded(
              child: Skeletonizer(
                enabled: _isLoading,
                effect: const ShimmerEffect(
                  baseColor: Color(0xFFE2E8F0),
                  highlightColor: Color(0xFFF8FAFC),
                  duration: Duration(seconds: 1),
                ),
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    // We pass "fake" data when loading, and Skeletonizer masks it automatically
                    return _UserCard(
                      name: _isLoading
                          ? 'Loading User Name'
                          : 'User Account ${index + 1}',
                      email: _isLoading
                          ? 'loading.email@provider.com'
                          : 'real.email.address@domain.com',
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The actual UI widget for a User Card.
/// Skeletonizer will automatically "skeletonize" this when enabled.
class _UserCard extends StatelessWidget {
  final String name;
  final String email;

  const _UserCard({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.black.withOpacity(0.05)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const CircleAvatar(
          radius: 28,
          backgroundColor: _accent,
          child: Icon(Icons.person_outline, color: Colors.white),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(email),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
