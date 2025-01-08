import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, '/todo'); // ใช้ routes เพื่อไปยัง TodoPage
            },
            child: const Text('Go to Todo Page'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, '/user'); // ใช้ routes เพื่อไปยัง UserPage
            },
            child: const Text('Go to User Page'),
          ),
        ],
      ),
    );
  }
}
