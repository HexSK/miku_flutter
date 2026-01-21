import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothController extends StatefulWidget {
  const BluetoothController({super.key});

  @override
  State<BluetoothController> createState() => _BluetoothControllerState();
}

class _BluetoothControllerState extends State<BluetoothController> {
  BluetoothConnection? connection;
  List<String> logs = [];
  String piAddress = "B8:27:EB:EF:E2:0C";

  void connect() async {
    try {
      connection = await BluetoothConnection.toAddress(piAddress);
      setState(() => logs.add("Connected to Pi!"));

      connection!.input!.listen((Uint8List data) {
        setState(() => logs.add("Pi: ${ascii.decode(data)}"));
      });
    } catch (e) {
      setState(() => logs.add("Failed to connect to Pi: $e"));
    }
  }

  void send(String text) {
    if (connection != null && connection!.isConnected) {
      connection!.output!.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
      setState(() => logs.add("Sent: $text"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: connect, child: const Text("Connect")),
        Expanded(
          child: ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(logs[index]));
            },
          ),
        ),
        TextField(
          onSubmitted: send,
          decoration: const InputDecoration(hintText: "Type to Pi: "),
        ),
      ],
    );
  }
}
