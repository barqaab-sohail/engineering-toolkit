import 'package:flutter/material.dart';
import 'solar_home.dart';

class SolarCalculator extends StatelessWidget {
  const SolarCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Solar System Calculator')),
      body: const SolarHome(),
    );
  }
}
