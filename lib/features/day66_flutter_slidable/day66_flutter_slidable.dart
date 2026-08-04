import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

const _accent = Color(0xFF6C5CE7);

class Day66FlutterSlidable extends StatefulWidget {
  const Day66FlutterSlidable({super.key});

  @override
  State<Day66FlutterSlidable> createState() => _Day66FlutterSlidableState();
}

class _Day66FlutterSlidableState extends State<Day66FlutterSlidable> {
  final List<String> _items = [
    'Flutter',
    'Dart',
    'Firebase',
    'GetX',
    'SQLite',
    'REST API',
  ];

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 66 - Flutter Slidable',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'flutter_slidable adds swipe actions to list items. '
                'Swipe left or right to reveal actions like Archive, Share, or Delete.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ListView.separated(
                itemCount: _items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = _items[index];

                  return Slidable(
                    startActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) => _showMessage('$item archived'),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          icon: Icons.archive_rounded,
                          label: 'Archive',
                        ),
                        SlidableAction(
                          onPressed: (_) => _showMessage('$item shared'),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.share_rounded,
                          label: 'Share',
                        ),
                      ],
                    ),

                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) => _showMessage('More options'),
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          icon: Icons.more_horiz_rounded,
                          label: 'More',
                        ),
                        SlidableAction(
                          onPressed: (_) {
                            setState(() {
                              _items.removeAt(index);
                            });

                            _showMessage('$item deleted');
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete_rounded,
                          label: 'Delete',
                        ),
                      ],
                    ),

                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _accent,
                          child: Text(
                            item[0],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          item,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: const Text('Swipe left or right'),
                        trailing: const Icon(Icons.swipe),
                      ),
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
