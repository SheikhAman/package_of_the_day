import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

const _accent = Color(0xFF6C5CE7);

class Day48ResponsiveFramework extends StatelessWidget {
  const Day48ResponsiveFramework({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Framework',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: _accent),

      /// Initializes Responsive Framework.
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: const [
            Breakpoint(start: 0, end: 450, name: MOBILE),
            Breakpoint(start: 451, end: 800, name: TABLET),
            Breakpoint(start: 801, end: 1200, name: DESKTOP),
            Breakpoint(start: 1201, end: double.infinity, name: '4K'),
          ],
        );
      },

      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);

    final isMobile = breakpoints.isMobile;
    final isTablet = breakpoints.isTablet;
    final isDesktop = breakpoints.isDesktop;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 48 · Responsive Framework',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),

        /// Hide the menu icon on desktop.
        leading: ResponsiveVisibility(
          hiddenConditions: const [Condition.largerThan(name: TABLET)],
          child: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ),

        actions: [
          ResponsiveVisibility(
            visible: false,
            visibleConditions: const [Condition.largerThan(name: TABLET)],
            child: TextButton(onPressed: () {}, child: const Text('Courses')),
          ),
          ResponsiveVisibility(
            visible: false,
            visibleConditions: const [Condition.largerThan(name: TABLET)],
            child: TextButton(onPressed: () {}, child: const Text('About')),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.email_outlined)),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: _accent,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text(
                'Responsive Framework',
                style: TextStyle(
                  color: Colors.white,

                  /// Responsive font size.
                  fontSize: ResponsiveValue<double>(
                    context,
                    defaultValue: 28,
                    conditionalValues: const [
                      Condition.smallerThan(name: MOBILE, value: 22),
                      Condition.largerThan(name: TABLET, value: 44),
                    ],
                  ).value,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            ResponsiveRowColumn(
              layout: isDesktop
                  ? ResponsiveRowColumnType.ROW
                  : ResponsiveRowColumnType.COLUMN,

              rowSpacing: 20,
              columnSpacing: 20,

              children: const [
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: _CourseCard(title: 'Flutter'),
                ),
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: _CourseCard(title: 'Dart'),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Current Breakpoint',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text('Mobile : $isMobile'),
                    Text('Tablet : $isTablet'),
                    Text('Desktop : $isDesktop'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final String title;

  const _CourseCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
