import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell, // navigationShell is the StatefulNavigationShell
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell, // *** body 에 StatefulNavigationShell( 경로 ) 지정
      bottomNavigationBar: BottomNavigationBar(
        // Here, the items of BottomNavigationBar are hard coded. In a real
        // world scenario, the items would most likely be generated from the
        // branches of the shell route, which can be fetched using
        // `navigationShell.route.branches`.
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.first_page), label: 'First'),
          BottomNavigationBarItem(icon: Icon(Icons.pages), label: 'Second'),
          BottomNavigationBarItem(icon: Icon(Icons.last_page), label: 'Third'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    // navigating to a new branch,
    // in order to make sure the last navigation state of the Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // if initialLocation is true,
      // this method will navigate to initial location of the active branch
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
