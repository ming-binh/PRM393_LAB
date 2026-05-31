import 'package:flutter/material.dart';
import 'Views/Pages/Ex1.dart';
import 'Views/Pages/Ex2.dart' hide Exercise1Screen;
import 'Views/Pages/Ex3.dart';
import 'Views/Pages/Ex4.dart';
import 'Views/Pages/Ex5.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const Lab4App());
}
class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Lab 4 - Flutter UI Fundamentals',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          home: const MainMenuScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 – Flutter UI Fundamentals'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMenuButton(context, 'Exercise 1 – Core Widgets Demo', const Exercise1Screen()),
          _buildMenuButton(context, 'Exercise 2 – Input Controls Demo', const Exercise2Screen()),
          _buildMenuButton(context, 'Exercise 3 – Layout Demo', const Exercise3Screen()),
          _buildMenuButton(context, 'Exercise 4 – App Structure & Theme', const Exercise4Screen()),
          _buildMenuButton(context, 'Exercise 5 – Common UI Fixes', const Exercise5Screen()),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, Widget screen) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16)),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}