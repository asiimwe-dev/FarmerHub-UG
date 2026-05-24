import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.child,
    required this.currentPath,
    super.key,
  });

  final Widget child;
  final String currentPath;

  static const _paths = [
    '/field-capture',
    '/traceability',
    '/forecasts',
  ];

  int _currentIndex() {
    final index = _paths.indexOf(currentPath);
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Farmer Hub UG')),
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex(),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dataset_outlined),
            label: 'Field Capture',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            label: 'Traceability',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            label: 'Forecasts',
          ),
        ],
        onDestinationSelected: (index) {
          context.go(_paths[index]);
        },
      ),
    );
  }
}
