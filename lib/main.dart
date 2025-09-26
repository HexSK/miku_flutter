import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MikuControllerApp());

class MikuControllerApp extends StatelessWidget {
  const MikuControllerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MikuAppBar());
  }
}

class MikuAppBar extends StatelessWidget{
  const MikuAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/miku.png',
          width:20,
          height: 20,
        ),
        title: Text('Miku Controller'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.egg),
          tooltip: 'MikuMikuBeam!:3',
          onPressed: () async {
            final player = AudioPlayer();
            await player.play(
              UrlSource(
                'https://www.myinstants.com/media/sounds/miku-miku-beam.mp3'
              ) 
            );
          }),
        ],
      ),
    );
  }
}