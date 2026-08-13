import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/counter_cubit.dart';

const _accent = Color(0xFF6366F1);

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Day 100 - Flutter BLoC',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCelebrationCard(),
            const SizedBox(height: 60),
            const Text(
              'REACTIVE STATE VALUE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: Colors.black26,
                letterSpacing: 2,
              ),
            ),

            // 🧩 THE BUILDER (UI Listener)
            BlocBuilder<CounterCubit, int>(
              builder: (context, count) {
                return Text(
                  '$count',
                  style: const TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.w900,
                    color: _accent,
                    letterSpacing: -5,
                  ),
                );
              },
            ),

            const SizedBox(height: 60),
            _buildControls(context),
          ],
        ),
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    return Row(
      children: [
        _buildCircularButton(
          icon: Icons.remove_rounded,
          onTap: () => context.read<CounterCubit>().decrement(),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildActionButton(
            label: 'RESET',
            icon: Icons.refresh_rounded,
            onTap: () => context.read<CounterCubit>().reset(),
          ),
        ),
        const SizedBox(width: 20),
        _buildCircularButton(
          icon: Icons.add_rounded,
          onTap: () => context.read<CounterCubit>().increment(),
        ),
      ],
    );
  }

  // --- Helper Widgets ---

  Widget _buildCelebrationCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _accent.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Column(
        children: [
          Icon(Icons.emoji_events_rounded, color: Colors.amber, size: 64),
          SizedBox(height: 16),
          Text(
            '100 PACKAGES EXPLORED!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 8),
          Text(
            'From UI helpers to Enterprise Architecture, you have mastered the Flutter ecosystem. Well done!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.black45, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Icon(icon, color: _accent, size: 28),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
    );
  }
}
