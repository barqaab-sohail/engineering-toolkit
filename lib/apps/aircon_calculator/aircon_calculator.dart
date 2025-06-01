import 'package:flutter/material.dart';
import 'aircon_home.dart';

class AirConCalculator extends StatelessWidget {
  const AirConCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Air Condition System Calculator')),
      body: const AirconHome(),
    );
  }
}
