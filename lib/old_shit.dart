import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('balls'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nehila is always watching pookie:3",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: Colors.amber[300],
                fontFamily: 'Oswald Medium',
              ),
            ),
            SizedBox(height: 20), // space between widgets
            Text("profesionalny dizajn webstranok 🔽🔽🔽"),
            SizedBox(height: 3),
            Image.network(
              'https://di.ics.upjs.sk/gunis/obrazky/gunis.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 5),
            Image.asset(
              'assets/gunis.jpg',
              width: 1000,
              height: 100,
              fit: BoxFit.fill,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('click'),
      ),
    );
  }
}
