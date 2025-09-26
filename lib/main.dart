import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/miku.png',
          height: 40
        ),
        title: Text('Miku Controller'),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade300,
      ),
      body: Center(
        child: Column(
          children: [],)
      ),
    );
  }
}
