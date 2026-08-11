import 'package:flutter/material.dart';
import '../models/user_profile_model.dart';

const _accent = Color(0xFF6366F1);

class ProfilePreviewCard extends StatelessWidget {
  final UserProfile user;
  const ProfilePreviewCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: _accent.withValues(alpha: 0.1),
            child: const Icon(Icons.account_circle, size: 40, color: _accent),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  user.email,
                  style: const TextStyle(color: Colors.black45, fontSize: 13),
                ),
              ],
            ),
          ),
          _OnlineBadge(isOnline: user.isOnline),
        ],
      ),
    );
  }
}

class _OnlineBadge extends StatelessWidget {
  final bool isOnline;
  const _OnlineBadge({required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isOnline
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isOnline ? 'ONLINE' : 'OFFLINE',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isOnline ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}
