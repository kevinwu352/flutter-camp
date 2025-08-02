import 'package:flutter/material.dart';

// Scaffold.of(context).openDrawer();
// Navigator.pop(context);

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DRAWER")),
      // drawer: Drawer(
      //   child: Drawer(
      //     child: ListView(
      //       // Important: Remove any padding from the ListView.
      //       padding: EdgeInsets.zero,
      //       children: [
      //         const DrawerHeader(
      //           decoration: BoxDecoration(color: Colors.blue),
      //           child: Text('Drawer Header'),
      //         ),
      //         ListTile(
      //           title: const Text('Item 1'),
      //           onTap: () {
      //             // ...
      //           },
      //         ),
      //         ListTile(
      //           title: const Text('Item 2'),
      //           onTap: () {
      //             // ...
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      drawer: NavigationDrawer(
        children: [
          Text("Header"),
          NavigationDrawerDestination(
            label: Text("111"),
            icon: Icon(Icons.person),
            selectedIcon: Icon(Icons.favorite),
          ),
          NavigationDrawerDestination(
            label: Text("111"),
            icon: Icon(Icons.person),
            selectedIcon: Icon(Icons.favorite),
          ),
          NavigationDrawerDestination(
            label: Text("111"),
            icon: Icon(Icons.person),
            selectedIcon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
