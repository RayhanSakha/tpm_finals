import 'package:flutter/material.dart';

class TimeConversionPage extends StatefulWidget {
  @override
  _TimeConversionPageState createState() => _TimeConversionPageState();
}

class _TimeConversionPageState extends State<TimeConversionPage> {
  String _fromTimezone = 'WIB';
  String _toTimezone = 'WIT';
  TimeOfDay _selectedTime = TimeOfDay.now();
  TimeOfDay _resultTime = TimeOfDay.now();

  final Map<String, int> _timezoneOffsets = {
    'WIB': 0,
    'WITA': 1,
    'WIT': 2,
    'London': -7,
  };

  void _convertTime() {
    int fromOffset = _timezoneOffsets[_fromTimezone] ?? 0;
    int toOffset = _timezoneOffsets[_toTimezone] ?? 0;
    int hourDifference = toOffset - fromOffset;

    setState(() {
      int newHour = (_selectedTime.hour + hourDifference) % 24;
      _resultTime = TimeOfDay(hour: newHour, minute: _selectedTime.minute);
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Time Conversion')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Selected Time: ${_selectedTime.format(context)}'),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select Time'),
            ),
            DropdownButton<String>(
              value: _fromTimezone,
              items: ['WIB', 'WITA', 'WIT', 'London'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _fromTimezone = value!;
                });
              },
            ),
            DropdownButton<String>(
              value: _toTimezone,
              items: ['WIB', 'WITA', 'WIT', 'London'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _toTimezone = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: _convertTime,
              child: Text('Convert'),
            ),
            Text('Result Time: ${_resultTime.format(context)}'),
          ],
        ),
      ),
    );
  }
}
