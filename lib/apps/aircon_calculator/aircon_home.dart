import 'package:flutter/material.dart';
import 'aircon_logic.dart';

class AirconHome extends StatefulWidget {
  const AirconHome({Key? key}) : super(key: key);

  @override
  State<AirconHome> createState() => _AirconHomeState();
}

class _AirconHomeState extends State<AirconHome> {
  final _formKey = GlobalKey<FormState>();
  double _width = 0;
  double _height = 0;
  double _depth = 0;
  bool _isTopFloor = false;
  double? _resultBTU;

  void _calculate() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      final result = calculateBTU(
        widthFt: _width,
        heightFt: _height,
        depthFt: _depth,
        isTopFloor: _isTopFloor,
      );

      setState(() {
        _resultBTU = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Air Conditioner Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Width (feet)'),
                keyboardType: TextInputType.number,
                onSaved: (val) => _width = double.tryParse(val ?? '') ?? 0,
                validator:
                    (val) =>
                        (val == null || double.tryParse(val) == null)
                            ? 'Enter a valid number'
                            : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Height (feet)'),
                keyboardType: TextInputType.number,
                onSaved: (val) => _height = double.tryParse(val ?? '') ?? 0,
                validator:
                    (val) =>
                        (val == null || double.tryParse(val) == null)
                            ? 'Enter a valid number'
                            : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Depth (feet)'),
                keyboardType: TextInputType.number,
                onSaved: (val) => _depth = double.tryParse(val ?? '') ?? 0,
                validator:
                    (val) =>
                        (val == null || double.tryParse(val) == null)
                            ? 'Enter a valid number'
                            : null,
              ),
              SwitchListTile(
                title: const Text("Is this room on the top floor?"),
                value: _isTopFloor,
                onChanged: (val) {
                  setState(() {
                    _isTopFloor = val;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _calculate,
                child: const Text("Calculate BTU"),
              ),
              if (_resultBTU != null) ...[
                const SizedBox(height: 20),
                Text(
                  "Required BTU: ${_resultBTU!.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
