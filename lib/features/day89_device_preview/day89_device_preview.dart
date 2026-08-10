import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:google_fonts/google_fonts.dart';

const _accent = Color(0xFF6366F1);

class Day89DevicePreview extends StatelessWidget {
  const Day89DevicePreview({super.key});

  @override
  Widget build(BuildContext context) {
    // We wrap the mock UI in DevicePreview to demonstrate
    // multi-device responsiveness within this specific day's feature.
    return DevicePreview(
      enabled: true,
      builder: (context) => const _InstagramProfileMock(),
    );
  }
}

class _InstagramProfileMock extends StatelessWidget {
  const _InstagramProfileMock();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We use the DevicePreview.appBuilder to ensure the simulated
      // device gets the correct media query data.
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'pieroborgo',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            fontSize: 20,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, size: 26),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu_rounded, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Profile Header ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.yellow,
                          Colors.orange,
                          Colors.pink,
                          Colors.purple,
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black12,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const _StatItem(label: 'Posts', count: '210'),
                  const SizedBox(width: 24),
                  const _StatItem(label: 'Followers', count: '600'),
                  const SizedBox(width: 24),
                  const _StatItem(label: 'Following', count: '500'),
                  const SizedBox(width: 8),
                ],
              ),
            ),

            // ── Profile Bio ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Piero Borgo',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const Text('Product Designer & Developer 🚀'),
                  const Text(
                    'Building 100 days of Flutter content...',
                    style: TextStyle(color: Color(0xFF00376B)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Action Buttons ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _ProfileButton(
                      label: 'Edit Profile',
                      color: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ProfileButton(
                      label: 'Share Profile',
                      color: Colors.grey.shade200,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Grid Section Header ────────────────────────────────
            const Divider(height: 0),
            const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Icon(Icons.grid_on_sharp),
                  ),
                ),
                Expanded(
                  child: Icon(
                    Icons.video_library_outlined,
                    color: Colors.black38,
                  ),
                ),
                Expanded(
                  child: Icon(Icons.person_pin_outlined, color: Colors.black38),
                ),
              ],
            ),

            // ── Grid View ──────────────────────────────────────────
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1.5,
                mainAxisSpacing: 1.5,
              ),
              itemCount: 15,
              itemBuilder: (context, index) => Container(
                color: Colors.grey.shade100,
                child: Icon(Icons.image_outlined, color: Colors.grey.shade300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label, count;
  const _StatItem({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),
      ],
    );
  }
}

class _ProfileButton extends StatelessWidget {
  final String label;
  final Color color;
  const _ProfileButton({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }
}
