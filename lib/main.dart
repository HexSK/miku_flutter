import 'package:flutter/material.dart';

import 'widgets/appbar.dart';
import 'widgets/connection_dialogue.dart';

void main() => runApp(MikuControllerApp());

class MikuControllerApp extends StatefulWidget {
  const MikuControllerApp({super.key});

  @override
  State<MikuControllerApp> createState() => _MikuControllerAppState();
}

class _MikuControllerAppState extends State<MikuControllerApp>{
  String connectionType = '';

  void _setConnectionType(String type){
    setState(() {
      connectionType = type;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: MikuAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConnectionDialogue(
                connectionType: connectionType,
                onConnectionSelected: _setConnectionType
              )
          ],
        ),
      )
    ),
  );
}
}

