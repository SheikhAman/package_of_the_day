import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// ── STEP 1: Use 'as p' to avoid naming collisions with BuildContext ──
import 'package:path/path.dart' as p;
import 'package:sembast/sembast_io.dart';

const _accent = Color(0xFF6366F1);

class Day96Sembast extends StatefulWidget {
  const Day96Sembast({super.key});

  @override
  State<Day96Sembast> createState() => _Day96SembastState();
}

class _Day96SembastState extends State<Day96Sembast> {
  final _controller = TextEditingController();

  // ── SEMBAST CONFIGURATION ──
  Database? _db;
  // A 'Store' is like a Table in SQL. We use String keys and Map values.
  final _store = stringMapStoreFactory.store('user_tasks');
  List<RecordSnapshot<String, Map<String, Object?>>> _records = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  // ── STEP 2: INITIALIZE (OPEN DATABASE) ──
  Future<void> _initDb() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      await dir.create(recursive: true);
      final dbPath = p.join(dir.path, 'package_of_the_day.db');

      // Open database for IO platforms
      _db = await databaseFactoryIo.openDatabase(dbPath);
      _loadTasks();
    } catch (e) {
      debugPrint('Database error: $e');
    }
  }

  // ── STEP 3: READ (FETCH DATA) ──
  Future<void> _loadTasks() async {
    if (_db == null) return;
    // Finder allows sorting. Here we sort by key descending (newest first).
    final finder = Finder(sortOrders: [SortOrder(Field.key, false)]);
    final snapshots = await _store.find(_db!, finder: finder);

    if (mounted) {
      setState(() {
        _records = snapshots;
        _isLoading = false;
      });
    }
  }

  // ── STEP 4: CREATE (ADD DATA) ──
  Future<void> _addTask() async {
    final text = _controller.text.trim();

    // Check if database is ready
    if (_db == null) return;

    // Professional Validation: Show warning if empty
    if (text.isEmpty) {
      _showToast('Please enter a note before saving', Colors.redAccent);
      return;
    }

    final task = {
      'title': text,
      'updated_at': DateTime.now().toIso8601String(),
    };

    await _store.add(_db!, task);
    _controller.clear();
    _loadTasks();
    _showToast('Note saved to disk', Colors.green);
  }

  // ── STEP 5: UPDATE (EDIT DATA) ──
  Future<void> _showEditDialog(String key, String currentTitle) async {
    final editController = TextEditingController(text: currentTitle);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Edit Note'),
        content: TextField(
          controller: editController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter new text...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: _accent),
            onPressed: () async {
              final newText = editController.text.trim();
              if (newText.isNotEmpty) {
                // Sembast specific record update logic
                await _store.record(key).update(_db!, {
                  'title': newText,
                  'updated_at': DateTime.now().toIso8601String(),
                });
                if (mounted) {
                  Navigator.pop(context);
                  _loadTasks();
                  _showToast('Record updated successfully', _accent);
                }
              } else {
                _showToast('Title cannot be empty', Colors.redAccent);
              }
            },
            child: const Text('SAVE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── STEP 6: DELETE (REMOVE DATA) ──
  Future<void> _deleteTask(String key) async {
    if (_db == null) return;
    await _store.record(key).delete(_db!);
    _loadTasks();
    _showToast('Record removed permanently', Colors.orange);
  }

  void _showToast(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Day 96 - Sembast DB'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoCard(),
            const SizedBox(height: 32),
            _buildInputSection(),
            const SizedBox(height: 32),
            const Text(
              'LOCAL DATABASE (NOSQL)',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: Colors.black38,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: _accent),
                    )
                  : _records.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      itemCount: _records.length,
                      itemBuilder: (context, index) {
                        final record = _records[index];
                        final title = record.value['title'] as String;
                        return _NoteTile(
                          title: title,
                          onEdit: () => _showEditDialog(record.key, title),
                          onDelete: () => _deleteTask(record.key),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (_) => _addTask(),
            decoration: InputDecoration(
              hintText: 'Add a quick note...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: _accent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: IconButton(
            onPressed: _addTask,
            icon: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
            padding: const EdgeInsets.all(14),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _accent.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Text(
        'Sembast is a pure Dart NoSQL database. This implementation covers the full CRUD lifecycle: '
        'Create, Read, Update, and Delete with local persistence.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, height: 1.5, color: Colors.black87),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.inventory_2_outlined, size: 64, color: Colors.black12),
        SizedBox(height: 16),
        Text(
          'No data found in storage',
          style: TextStyle(color: Colors.black26, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _NoteTile extends StatelessWidget {
  final String title;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _NoteTile({
    required this.title,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFEEF2FF),
          child: Icon(Icons.notes_rounded, color: _accent, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.blueAccent,
                size: 20,
              ),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.redAccent,
                size: 20,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
