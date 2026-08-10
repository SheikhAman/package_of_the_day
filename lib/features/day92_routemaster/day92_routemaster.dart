import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'pages/pages.dart';

const _accent = Color(0xFF6366F1);

/// The RouteMap defines the entire navigation structure.
/// It maps URL strings to physical Page widgets.
final _routes = RouteMap(
  routes: {
    '/': (_) => CupertinoTabPage(
      child: const _MainTabsHolder(),
      paths: ['/feed', '/settings'],
    ),
    '/feed': (_) => const MaterialPage(child: FeedPage()),
    '/feed/profile/:id': (route) =>
        MaterialPage(child: ProfilePage(id: route.pathParameters['id'] ?? '0')),
    '/settings': (_) => const MaterialPage(child: SettingsPage()),
  },
);

class Day92Routemaster extends StatelessWidget {
  const Day92Routemaster({super.key});

  @override
  Widget build(BuildContext context) {
    // Routemaster uses the modern MaterialApp.router constructor
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Day 92 - Routemaster',
      theme: ThemeData(
        primaryColor: _accent,
        colorScheme: ColorScheme.fromSeed(seedColor: _accent),
        useMaterial3: true,
      ),
      routerDelegate: RoutemasterDelegate(routesBuilder: (_) => _routes),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}

/// A holder widget that connects Routemaster's tab state to a CupertinoTabScaffold.
/// This allows for persistent tab state during navigation.
class _MainTabsHolder extends StatelessWidget {
  const _MainTabsHolder();

  @override
  Widget build(BuildContext context) {
    final tabState = CupertinoTabPage.of(context);

    return Scaffold(
      body: CupertinoTabScaffold(
        controller: tabState.controller,
        tabBuilder: tabState.tabBuilder,
        tabBar: CupertinoTabBar(
          activeColor: _accent,
          inactiveColor: Colors.black38,
          items: const [
            BottomNavigationBarItem(
              label: 'Community',
              icon: Icon(Icons.dynamic_feed_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
