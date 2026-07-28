import 'package:flutter/material.dart';
import 'package:timelines_upgraded/timelines_upgraded.dart';

const _accent = Color(0xFF6C5CE7);

// timelines (originally requested) is unmaintained. timelines_upgraded is
// an actively maintained fork of the same package — same API
// (Timeline.tileBuilder, TimelineTileBuilder.fromStyle, same enum names),
// just a different import, updated to work with current Dart/Flutter SDKs.

class Day49TimelinesUpgraded extends StatelessWidget {
  const Day49TimelinesUpgraded({super.key});

  static const List<Map<String, dynamic>> _events = [
    {
      'title': 'Order Placed',
      'time': 'Mon, 9:12 AM',
      'icon': Icons.shopping_bag_rounded,
    },
    {
      'title': 'Payment Confirmed',
      'time': 'Mon, 9:14 AM',
      'icon': Icons.credit_card_rounded,
    },
    {
      'title': 'Packed',
      'time': 'Mon, 3:40 PM',
      'icon': Icons.inventory_2_rounded,
    },
    {
      'title': 'Shipped',
      'time': 'Tue, 8:05 AM',
      'icon': Icons.local_shipping_rounded,
    },
    {
      'title': 'Out for Delivery',
      'time': 'Wed, 7:50 AM',
      'icon': Icons.delivery_dining_rounded,
    },
    {
      'title': 'Delivered',
      'time': 'Wed, 11:22 AM',
      'icon': Icons.check_circle_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 49 - Timelines',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // ── Info card ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Container(
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
                'Renders a vertical timeline of connected steps — a natural '
                'fit for order tracking, onboarding progress, or activity '
                'history.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),
          ),

          // ── Timeline ─────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Timeline.tileBuilder(
                builder: TimelineTileBuilder.fromStyle(
                  contentsAlign: ContentsAlign.basic,
                  connectorStyle: ConnectorStyle.solidLine,
                  indicatorStyle: IndicatorStyle.dot,
                  contentsBuilder: (context, index) {
                    final event = _events[index];
                    final isLast = index == _events.length - 1;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(14),
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
                            Container(
                              width: 38,
                              height: 38,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: (isLast
                                    ? _accent
                                    : _accent.withValues(alpha: 0.1)),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                event['icon'],
                                color: isLast ? Colors.white : _accent,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event['title'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    event['time'],
                                    style: const TextStyle(
                                      fontSize: 11.5,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: _events.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
