import 'package:flutter/material.dart';
import '../../main.dart'; // Đã cập nhật lại đường dẫn lùi 2 cấp thư mục

class Exercise4Screen extends StatelessWidget {
  const Exercise4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4 – App Str...'),
        actions: [
          Row(
            children: [
              const Text('Dark'),
              ValueListenableBuilder<ThemeMode>(
                valueListenable: themeNotifier,
                builder: (_, ThemeMode currentMode, __) {
                  return Switch(
                    value: currentMode == ThemeMode.dark,
                    onChanged: (isDark) {
                      themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
      body: const Center(
        child: Text('This is a simple screen with theme toggle.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}