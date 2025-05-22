import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

// Root widget
class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TemperatureConverterScreen(),
    );
  }
}

// Stateful widget for the converter screen
class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String _conversionType = 'Fahrenheit to Celsius';
  String _result = '';

  void _convertTemperature() {
    final input = double.tryParse(_controller.text);
    if (input == null) {
      setState(() {
        _result = 'Please enter a valid number';
      });
      return;
    }

    double output;
    if (_conversionType == 'Fahrenheit to Celsius') {
      output = (input - 32) * 5 / 9;
      _result =
          '${input.toStringAsFixed(2)}°F = ${output.toStringAsFixed(2)}°C';
    } else {
      output = (input * 9 / 5) + 32;
      _result =
          '${input.toStringAsFixed(2)}°C = ${output.toStringAsFixed(2)}°F';
    }

    setState(() {}); // Trigger UI update
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temperature Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _conversionType,
              items:
                  ['Fahrenheit to Celsius', 'Celsius to Fahrenheit'].map((
                    String value,
                  ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (String? newType) {
                setState(() {
                  _conversionType = newType!;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
