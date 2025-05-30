import 'package:flutter/material.dart';

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  State<TemperatureConverterScreen> createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  final TextEditingController _tempController = TextEditingController();
  ConversionType _conversionType = ConversionType.fahrenheitToCelsius;
  String _result = '';
  final List<String> _conversionHistory = [];

  @override
  void dispose() {
    _tempController.dispose();
    super.dispose();
  }

  void _convertTemperature() {
    if (_tempController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a temperature value')),
      );
      return;
    }

    final input = double.tryParse(_tempController.text);
    if (input == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number')),
      );
      return;
    }

    double convertedTemp;
    String historyEntry;

    if (_conversionType == ConversionType.fahrenheitToCelsius) {
      convertedTemp = (input - 32) * 5 / 9;
      historyEntry =
          'F to C: ${input.toStringAsFixed(1)} → ${convertedTemp.toStringAsFixed(2)}';
    } else {
      convertedTemp = input * 9 / 5 + 32;
      historyEntry =
          'C to F: ${input.toStringAsFixed(1)} → ${convertedTemp.toStringAsFixed(2)}';
    }

    setState(() {
      _result =
          '${convertedTemp.toStringAsFixed(2)}° ${_conversionType == ConversionType.fahrenheitToCelsius ? 'C' : 'F'}';
      _conversionHistory.insert(0, historyEntry);
      _tempController.clear(); // Add this line to clear the input
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converter'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 84, 96, 201),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Conversion:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Conversion Type Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _conversionType == ConversionType.fahrenheitToCelsius
                            ? const Color.fromARGB(255, 42, 42, 42)
                            : const Color.fromARGB(255, 255, 255, 255),
                    foregroundColor:
                        _conversionType == ConversionType.fahrenheitToCelsius
                            ? Colors
                                .white // Text color when button is selected
                            : Colors
                                .black, // Text color when button is not selected
                  ),
                  onPressed: () {
                    setState(() {
                      _conversionType = ConversionType.fahrenheitToCelsius;
                    });
                  },
                  child: const Text('Fahrenheit to Celsius'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _conversionType == ConversionType.celsiusToFahrenheit
                            ? const Color.fromARGB(255, 42, 42, 42)
                            : const Color.fromARGB(255, 255, 255, 255),
                    foregroundColor:
                        _conversionType == ConversionType.celsiusToFahrenheit
                            ? Colors
                                .white // Text color when button is selected
                            : Colors
                                .black, // Text color when button is not selected
                  ),
                  onPressed: () {
                    setState(() {
                      _conversionType = ConversionType.celsiusToFahrenheit;
                    });
                  },
                  child: const Text('Celsius to Fahrenheit'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Input and Output Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tempController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      labelText: 'Input',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _result.isEmpty ? 'Result' : _result,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _result.isEmpty ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Convert Button
            Center(
              child: ElevatedButton(
                onPressed: _convertTemperature,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  // Add background color that changes when pressed
                  backgroundColor: const Color.fromARGB(255, 42, 42, 42),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Convert',
                  style: TextStyle(
                    fontSize: 25, // Increased font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Conversion History
            const Text(
              'Conversion History:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 460,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child:
                  _conversionHistory.isEmpty
                      ? const Center(
                        child: Text(
                          'No conversions yet',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                      : ListView.builder(
                        itemCount: _conversionHistory.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_conversionHistory[index]),
                            leading: const Icon(Icons.arrow_right),
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

enum ConversionType { fahrenheitToCelsius, celsiusToFahrenheit }
