import 'package:flutter/material.dart';
import 'app_model.dart';
import 'solar_calculator/solar_calculator.dart';
import 'aircon_calculator/aircon_calculator.dart';

List<AppModel> appsList = [
  AppModel(
    id: 'solar_calculator',
    title: 'Solar System',
    description: 'Calculate solar panel requirements',
    icon: Icons.wb_sunny,
    screen: const SolarCalculator(),
    color: Colors.orange,
  ),
  AppModel(
    id: 'aircon_calculator',
    title: 'Air Conditioner',
    description: 'Calculate AC requirements for rooms',
    icon: Icons.ac_unit,
    screen: const AirConCalculator(),
    color: Colors.blue,
  ),
  // Add more apps here following the same pattern
];
