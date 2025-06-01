import 'package:flutter/material.dart';

/// Model class representing a mini-application in your dashboard
class AppModel {
  final String id; // Unique identifier for the app
  final String title; // Display name (e.g., "Solar Calculator")
  final String description; // Short description
  final IconData icon; // Icon to display in dashboard
  final Widget screen; // The actual app screen widget
  final Color color; // Theme color for the app

  const AppModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.screen,
    this.color = Colors.blue, // Default color if not specified
  });

  // Optional: Helper method to generate a MaterialColor from any Color
  MaterialColor get materialColor => MaterialColor(color.value, <int, Color>{
    50: color.withOpacity(0.1),
    100: color.withOpacity(0.2),
    200: color.withOpacity(0.3),
    300: color.withOpacity(0.4),
    400: color.withOpacity(0.5),
    500: color.withOpacity(0.6),
    600: color.withOpacity(0.7),
    700: color.withOpacity(0.8),
    800: color.withOpacity(0.9),
    900: color.withOpacity(1),
  });
}
