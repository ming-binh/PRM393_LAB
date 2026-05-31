import 'package:flutter/material.dart';

class Exercise5Screen extends StatefulWidget {
  const Exercise5Screen({super.key});

  @override
  State<Exercise5Screen> createState() => _Exercise5ScreenState();
}

class _Exercise5ScreenState extends State<Exercise5Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 5 – Common UI Fixes')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Correct ListView inside Column using Expanded',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: ListView(
                  children: const [
                    ListTile(leading: Icon(Icons.movie), title: Text('Movie A')),
                    ListTile(leading: Icon(Icons.movie), title: Text('Movie B')),
                    ListTile(leading: Icon(Icons.movie), title: Text('Movie C')),
                    ListTile(leading: Icon(Icons.movie), title: Text('Movie D')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}