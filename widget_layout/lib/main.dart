import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Student Profile'),
        ),
        body: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Flutter'),
            ),
            ListTile(
              leading: Icon(Icons.cloud),
              title: Text('Cloud Computing'),
            ),
            ListTile(
              leading: Icon(Icons.code),
              title: Text('Programming'),
            ),
          ],
        ),
      ),
    );
  }
}
