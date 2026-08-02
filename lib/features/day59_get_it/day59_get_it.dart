import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_of_the_day/features/day59_get_it/counter_service.dart';

const _accent = Color(0xFF6C5CE7);

final getIt = GetIt.instance;

/// Call this once from your app's startup.
void setupGetIt() {
  if (!getIt.isRegistered<CounterService>()) {
    getIt.registerLazySingleton<CounterService>(CounterService.new);
  }
}

class Day59GetIt extends StatelessWidget {
  const Day59GetIt({super.key});

  @override
  Widget build(BuildContext context) {
    setupGetIt();
    final counterService = getIt<CounterService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 59 - GetIt',
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
                'GetIt is a lightweight service locator for dependency injection. '
                'Register your services once and access them anywhere without '
                'passing objects through widget constructors.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const Spacer(),

            ListenableBuilder(
              listenable: counterService,
              builder: (context, _) {
                return Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [_accent, Color(0xFF8E7CFF)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _accent.withValues(alpha: .25),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.miscellaneous_services_rounded,
                        size: 72,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${counterService.count}',
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Counter Service',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            FilledButton.icon(
              onPressed: counterService.increment,
              style: FilledButton.styleFrom(
                backgroundColor: _accent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Increment Counter'),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
