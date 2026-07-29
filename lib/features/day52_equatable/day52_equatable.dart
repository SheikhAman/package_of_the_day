import 'package:flutter/material.dart';
import 'package:package_of_the_day/features/day52_equatable/user_model.dart';

const _accent = Color(0xFF6C5CE7);

class Day52Equatable extends StatelessWidget {
  const Day52Equatable({super.key});

  @override
  Widget build(BuildContext context) {
    const james = User(name: 'James', role: 'Flutter Developer');

    const sarah = User(name: 'Sarah', role: 'UI Designer');

    const sarahCopy = User(name: 'Sarah', role: 'UI Designer');

    final results = [
      _Comparison(title: 'James == Sarah', value: james == sarah),
      _Comparison(title: 'Sarah == Sarah', value: sarah == sarah),
      _Comparison(title: 'Sarah == Sarah Copy', value: sarah == sarahCopy),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 52 - Equatable',
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
                'Equatable lets Dart compare objects by their values instead of memory references, making model comparisons simple and reliable.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _UserCard(
                  name: 'James',
                  role: 'Flutter Developer',
                  icon: Icons.person,
                ),
                _UserCard(
                  name: 'Sarah',
                  role: 'UI Designer',
                  icon: Icons.person_outline,
                ),
              ],
            ),

            const SizedBox(height: 40),

            Expanded(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: results.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (_, index) {
                  final item = results[index];

                  return Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .05),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: item.value
                                ? Colors.green.withValues(alpha: .12)
                                : Colors.red.withValues(alpha: .12),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            item.value ? 'TRUE' : 'FALSE',
                            style: TextStyle(
                              color: item.value ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Comparison {
  final String title;
  final bool value;

  const _Comparison({required this.title, required this.value});
}

class _UserCard extends StatelessWidget {
  final String name;
  final String role;
  final IconData icon;

  const _UserCard({required this.name, required this.role, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [_accent, Color(0xFF8E7CFF)]),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: _accent.withValues(alpha: .28),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: Icon(icon, size: 32, color: _accent),
          ),
          const SizedBox(height: 14),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            role,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: .9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
