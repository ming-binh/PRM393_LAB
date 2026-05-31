import 'package:flutter/material.dart';

class Exercise3Screen extends StatelessWidget {
  const Exercise3Screen({super.key});

  final List<Map<String, String>> movies = const [
    {'title': 'Avatar', 'initial': 'A'},
    {'title': 'Inception', 'initial': 'I'},
    {'title': 'Interstellar', 'initial': 'I'},
    {'title': 'Joker', 'initial': 'J'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 3 – Layout Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Now Playing',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo.shade100,
                        child: Text(movies[index]['initial']!),
                      ),
                      title: Text(movies[index]['title']!),
                      subtitle: const Text('Sample description'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}