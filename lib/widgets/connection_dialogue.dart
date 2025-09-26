import 'package:flutter/material.dart';

class ConnectionDialogue extends StatelessWidget {
  final String connectionType;
  final void Function(String) onConnectionSelected;

  const ConnectionDialogue({
    super.key,
    required this.connectionType,
    required this.onConnectionSelected,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('What is your connection type?'),
        const SizedBox(height: 16), // Added spacing
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Better spacing
          children: [
            ElevatedButton(
              onPressed: () => onConnectionSelected('usb'),
              child: const Row(
                children: [
                  Icon(Icons.usb),
                  SizedBox(width: 8), // Added spacing
                  Text('USB Serial'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => onConnectionSelected('bluetooth'),
              child: const Row(
                children: [
                  Icon(Icons.bluetooth),
                  SizedBox(width: 8), // Added spacing
                  Text('Bluetooth'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text('Selected: $connectionType'), // Show selection
      ],
    );
  }
}
