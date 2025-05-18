import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  static const tabs = [
    _TabItem(icon: Icons.home, route: '/', label: 'Home'),
    _TabItem(icon: Icons.person, route: '/profile', label: 'Profile'),
  ];

  int _locationToTabIndex(String location) {
    final index = tabs.indexWhere((tab) => location == tab.route);
    return index >= 0 ? index : 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToTabIndex(location);

    return SafeArea(
      child: Scaffold(
        body: child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          destinations: [
            for (final tab in tabs)
              NavigationDestination(icon: Icon(tab.icon), label: tab.label, tooltip: tab.label),
          ],
          onDestinationSelected: (index) {
            final newRoute = tabs[index].route;
            if (newRoute != location) context.go(newRoute);
          },
        ),
      ),
    );
  }
}

class _TabItem {
  final IconData icon;
  final String route;
  final String label;

  const _TabItem({required this.icon, required this.route, required this.label});
}
