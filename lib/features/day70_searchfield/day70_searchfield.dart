import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

const _accent = Color(0xFF6C5CE7);

class Day70SearchField extends StatefulWidget {
  const Day70SearchField({super.key});

  @override
  State<Day70SearchField> createState() => _Day70SearchFieldState();
}

class _Day70SearchFieldState extends State<Day70SearchField> {
  final TextEditingController _controller = TextEditingController();

  final List<String> _users = [
    'Aman',
    'Siam',
    'Rahim',
    'Karim',
    'Flutter Developer',
    'Android Developer',
    'iOS Developer',
    'Backend Developer',
    'Firebase Expert',
    'UI Designer',
  ];

  List<String> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = _users;
  }

  void _searchUser(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredUsers = _users;
      } else {
        filteredUsers = _users
            .where((user) => user.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 70 - SearchField',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
                'SearchField provides an autocomplete search experience '
                'with suggestions. It is useful for searching users, '
                'products, locations, and API data.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, height: 1.5),
              ),
            ),

            const SizedBox(height: 25),

            SearchField<String>(
              controller: _controller,

              suggestions: _users
                  .map(
                    (user) => SearchFieldListItem<String>(
                      user,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(user, style: const TextStyle(fontSize: 16)),
                      ),
                    ),
                  )
                  .toList(),

              suggestionState: Suggestion.expand,

              searchInputDecoration: SearchInputDecoration(
                labelText: 'Search User',
                hintText: 'Type a name...',
                prefixIcon: const Icon(Icons.search, color: _accent),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),

              onSuggestionTap: (value) {
                _controller.text = value.searchKey;

                _searchUser(value.searchKey);
              },

              onSubmit: (value) {
                _searchUser(value);
              },

              onSearchTextChanged: (value) {
                _searchUser(value);

                return _users
                    .where(
                      (element) =>
                          element.toLowerCase().contains(value.toLowerCase()),
                    )
                    .map((e) => SearchFieldListItem<String>(e))
                    .toList();
              },
            ),

            const SizedBox(height: 25),

            Expanded(
              child: ListView.separated(
                itemCount: filteredUsers.length,

                separatorBuilder: (_, __) => const SizedBox(height: 10),

                itemBuilder: (context, index) {
                  final user = filteredUsers[index];

                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),

                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _accent,
                        child: Text(
                          user[0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),

                      title: Text(
                        user,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),

                      subtitle: const Text('SearchField result'),
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
