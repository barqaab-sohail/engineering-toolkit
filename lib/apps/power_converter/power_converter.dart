import 'package:flutter/material.dart';
import 'power_home.dart';

class PowerConverter extends StatelessWidget {
  const PowerConverter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Power Converter')),
      body: const PowerHome(),
    );
  }
}
