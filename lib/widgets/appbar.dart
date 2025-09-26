import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MikuAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MikuAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Image.asset(
        'assets/miku.png',
        width:20,
        height: 20,
      ),
      title: Text(
        'Miku Controller',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        )
      ),
      centerTitle: true,
      backgroundColor: Colors.cyan.shade700,
      actions: <Widget>[
        IconButton(
        icon: const Icon(Icons.egg),
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
    );
  }
}