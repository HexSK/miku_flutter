import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miku Controller',
      theme: ThemeData(
        useMaterial3: true,  // ← This enables Material 3!
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,  // ← Miku's color!
          brightness: Brightness.light,
        ),
      ),
      home: const CustomBottomNavigationBar(),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  
  static const List<Widget> _widgetOptions = <Widget>[
    WiFiControl(),    // We'll create this next
    BLEControl(),     // We'll create this next  
    USBControl(),     // We'll create this next
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/miku.png',
            height: 40,
          ),
        ),
        title: _getTitle(_selectedIndex),
        centerTitle: true,
        // No need for backgroundColor - Material 3 handles it!
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        // Material 3's new navigation bar!
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.wifi),
            label: 'Wi-Fi',
          ),
          NavigationDestination(
            icon: Icon(Icons.bluetooth),
            label: 'Bluetooth',
          ),
          NavigationDestination(
            icon: Icon(Icons.usb),
            label: 'USB',
          ),
        ],
      ),
    );
  }
  
  Widget _getTitle(int index) {
    switch (index) {
      case 0: return const Text('Miku Control | Wi-Fi');
      case 1: return const Text('Miku Control | BT');
      case 2: return const Text('Miku Control | USB Mikro-typ B');
      default: return const Text('Miku Control');
    }
  }
}

// Temporary placeholder widgets
class WiFiControl extends StatelessWidget {
  const WiFiControl({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Wi-Fi Control Page - Coming Soon!'));
  }
}

class BLEControl extends StatelessWidget {
  const BLEControl({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Bluetooth Control Page - Coming Soon!'));
  }
}

class USBControl extends StatelessWidget {
  const USBControl({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('USB Control Page - Coming Soon!'));
  }
}