import 'package:flutter/material.dart';
import 'power_logic.dart';

class PowerHome extends StatefulWidget {
  const PowerHome({super.key});

  @override
  State<PowerHome> createState() => _PowerHomeState();
}

class _PowerHomeState extends State<PowerHome> {
  final _formKey = GlobalKey<FormState>();
  final _inputController = TextEditingController();
  final _voltageController = TextEditingController(text: '230');
  final _pfController = TextEditingController(text: '0.8');
  String _selectedConversion = 'kW to Amps (1P)';
  String _result = '';
  String _inputLabel = 'kW Value'; // Track current input label

  final List<String> _conversionTypes = [
    'kW to Amps (1P)',
    'Amps to kW (1P)',
    'kW to Amps (3P)',
    'Amps to kW (3P)',
    'HP to kW',
    'kW to HP',
    'BTU to kW',
    'kW to BTU',
  ];

  // Update input label when conversion type changes
  void _updateInputLabel() {
    setState(() {
      if (_selectedConversion.contains('kW to Amps')) {
        _inputLabel = 'kW Value';
      } else if (_selectedConversion.contains('Amps to kW')) {
        _inputLabel = 'Amps Value';
      } else if (_selectedConversion.contains('HP to kW')) {
        _inputLabel = 'HP Value';
      } else if (_selectedConversion.contains('kW to HP')) {
        _inputLabel = 'kW Value';
      } else if (_selectedConversion.contains('BTU to kW')) {
        _inputLabel = 'BTU Value';
      } else if (_selectedConversion.contains('kW to BTU')) {
        _inputLabel = 'kW Value';
      }
    });
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final voltage = double.tryParse(_voltageController.text) ?? 230;
    final pf = double.tryParse(_pfController.text) ?? 0.8;
    final inputValue = double.tryParse(_inputController.text) ?? 0;

    setState(() {
      switch (_selectedConversion) {
        case 'kW to Amps (1P)':
          _result =
              '${PowerConverter.kwToAmpsSinglePhase(inputValue, voltage, pf: pf).toStringAsFixed(2)} A';
          break;
        case 'Amps to kW (1P)':
          _result =
              '${PowerConverter.ampsToKwSinglePhase(inputValue, voltage, pf: pf).toStringAsFixed(2)} kW';
          break;
        case 'kW to Amps (3P)':
          _result =
              '${PowerConverter.kwToAmpsThreePhase(inputValue, voltage, pf: pf).toStringAsFixed(2)} A';
          break;
        case 'Amps to kW (3P)':
          _result =
              '${PowerConverter.ampsToKwThreePhase(inputValue, voltage, pf: pf).toStringAsFixed(2)} kW';
          break;
        case 'HP to kW':
          _result =
              '${PowerConverter.hpToKw(inputValue).toStringAsFixed(2)} kW';
          break;
        case 'kW to HP':
          _result =
              '${PowerConverter.kwToHp(inputValue).toStringAsFixed(2)} HP';
          break;
        case 'BTU to kW':
          _result =
              '${PowerConverter.btuToKw(inputValue).toStringAsFixed(4)} kW';
          break;
        case 'kW to BTU':
          _result =
              '${PowerConverter.kwToBtu(inputValue).toStringAsFixed(2)} BTU';
          break;
      }
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _voltageController.dispose();
    _pfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedConversion,
              items:
                  _conversionTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedConversion = value!;
                  _result = '';
                  _inputController.clear();
                  _updateInputLabel(); // Update label when selection changes
                });
              },
              decoration: const InputDecoration(
                labelText: 'Conversion Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: _inputLabel, // Use the dynamic label
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter a value';
                if (double.tryParse(value) == null) return 'Invalid number';
                return null;
              },
            ),
            if (_selectedConversion.contains('Amps') ||
                _selectedConversion.contains('kW'))
              Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _voltageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Voltage (V)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (_selectedConversion.contains('Amps') ||
                          _selectedConversion.contains('kW')) {
                        if (value == null || value.isEmpty)
                          return 'Enter voltage';
                        if (double.tryParse(value) == null)
                          return 'Invalid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _pfController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Power Factor (0.8-1)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (_selectedConversion.contains('Amps') ||
                          _selectedConversion.contains('kW')) {
                        if (value == null || value.isEmpty)
                          return 'Enter power factor';
                        final pf = double.tryParse(value);
                        if (pf == null || pf < 0.1 || pf > 1)
                          return 'Must be 0.1-1.0';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 30),
            if (_result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Result: $_result',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
