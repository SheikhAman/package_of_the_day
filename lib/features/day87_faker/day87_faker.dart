import 'package:flutter/material.dart';
// We "hide Color" from faker to prevent it from conflicting with Flutter's Color class
import 'package:faker/faker.dart' hide Color;
import 'package:date_format/date_format.dart';

const _accent = Color(0xFF6366F1);

class Day87Faker extends StatefulWidget {
  const Day87Faker({super.key});

  @override
  State<Day87Faker> createState() => _Day87FakerState();
}

class _Day87FakerState extends State<Day87Faker> {
  // State variables for our "Generated User"
  String _name = 'Tap generate to start';
  String _email = '';
  String _job = '';
  String _company = '';
  String _address = '';
  String _currency = '';
  String _birthday = '';

  @override
  void initState() {
    super.initState();
    _generateMockData();
  }

  /// Generates a new set of random data using various faker providers.
  void _generateMockData() {
    setState(() {
      // Accessing faker providers (Person, Internet, Job, etc.)
      _name = '${faker.person.firstName()} ${faker.person.lastName()}';
      _email = faker.internet.email();
      _job = faker.job.title();
      _company = faker.company.name();
      _address = '${faker.address.city()}, ${faker.address.country()}';
      _currency = '${faker.currency.name()} (${faker.currency.code()})';

      // Generating a random date and formatting it using Day 80's package
      final date = faker.date.dateTime(minYear: 1970, maxYear: 2005);
      _birthday = formatDate(date, [MM, ' ', dd, ', ', yyyy]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day 87 - Faker Data'),
        actions: [
          IconButton(
            onPressed: _generateMockData,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                    color: _accent.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Text(
                'Faker helps you build and test UIs by generating realistic mock data. '
                'It prevents you from having to type "Test User" manually over and over.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ── Generated Profile Card ─────────────────────────────
            _ProfileHeader(name: _name, job: _job, company: _company),

            const SizedBox(height: 24),

            // ── Details Section ────────────────────────────────────
            _DataTile(
              label: 'EMAIL ADDRESS',
              value: _email,
              icon: Icons.alternate_email_rounded,
            ),
            _DataTile(
              label: 'HOME ADDRESS',
              value: _address,
              icon: Icons.location_on_outlined,
            ),
            _DataTile(
              label: 'DATE OF BIRTH',
              value: _birthday,
              icon: Icons.cake_outlined,
            ),
            _DataTile(
              label: 'PREFERRED CURRENCY',
              value: _currency,
              icon: Icons.payments_outlined,
            ),

            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: _generateMockData,
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 64),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'GENERATE NEW PERSONA',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String name, job, company;
  const _ProfileHeader({
    required this.name,
    required this.job,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: _accent,
            child: Icon(
              Icons.person_outline_rounded,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$job @ $company',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: _accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DataTile extends StatelessWidget {
  final String label, value;
  final IconData icon;

  const _DataTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: _accent, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
