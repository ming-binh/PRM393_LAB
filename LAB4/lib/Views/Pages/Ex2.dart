import 'package:flutter/material.dart';

class Exercise2Screen extends StatefulWidget {
  const Exercise2Screen({super.key});

  @override
  State<Exercise2Screen> createState() => _Exercise2ScreenState();
}

class _Exercise2ScreenState extends State<Exercise2Screen> {
  double _sliderValue = 50;
  bool _isSwitchOn = false;
  String _selectedGenre = 'None';
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2 – Input Controls')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rating (Slider)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              onChanged: (value) {
                setState(() => _sliderValue = value);
              },
            ),
            Text('Current value: ${_sliderValue.toInt()}'),
            const SizedBox(height: 20),

            const Text('Active (Switch)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Is movie active?'),
                Switch(
                  value: _isSwitchOn,
                  onChanged: (value) {
                    setState(() => _isSwitchOn = value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text('Genre (RadioListTile)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            RadioListTile<String>(
              title: const Text('Action'),
              value: 'Action',
              groupValue: _selectedGenre,
              onChanged: (value) => setState(() => _selectedGenre = value!),
            ),
            RadioListTile<String>(
              title: const Text('Comedy'),
              value: 'Comedy',
              groupValue: _selectedGenre,
              onChanged: (value) => setState(() => _selectedGenre = value!),
            ),
            Text('Selected genre: $_selectedGenre'),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _selectDate(context),
                child: Text(_selectedDate == null
                    ? 'Open Date Picker'
                    : 'Selected Date: ${_selectedDate!.toLocal()}'.split(' ')[0]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}