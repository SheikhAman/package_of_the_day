import 'package:flutter/material.dart';
import 'package:package_of_the_day/features/day37_shimmer/model/food_model.dart';
import 'package:package_of_the_day/features/day37_shimmer/widget/shimmer_card.dart';

const _accent = Color(0xFF6C5CE7);

const List<FoodModel> _allFoods = [
  FoodModel('Apple', Icons.apple, 'An apple a day keeps the doctor away.'),
  FoodModel(
    'Banana',
    Icons.emoji_food_beverage_rounded,
    'A banana a day keeps the doctor away.',
  ),
  FoodModel('Orange', Icons.circle, 'An orange a day keeps the doctor away.'),
];

class Day37Shimmer extends StatefulWidget {
  const Day37Shimmer({super.key});

  @override
  State<Day37Shimmer> createState() => _Day37ShimmerState();
}

class _Day37ShimmerState extends State<Day37Shimmer> {
  bool _isLoading = true;
  List<FoodModel> _foods = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _foods = List.of(_allFoods);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 37 · Shimmer',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info card ──────────────────────────────────────────
            Container(
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
                'shimmer draws an animated shine over placeholder shapes '
                'while real content loads — much more polished than a bare '
                'spinner for list-style UIs.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.separated(
                itemCount: _isLoading ? 4 : _foods.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _isLoading
                      ? const ShimmerCard()
                      : _FoodCard(food: _foods[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FoodCard extends StatelessWidget {
  final FoodModel food;
  const _FoodCard({required this.food});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(food.icon, color: _accent, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  food.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12.5, color: Colors.black45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
