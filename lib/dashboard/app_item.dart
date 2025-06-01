import 'package:flutter/material.dart';
import '../apps/app_model.dart';

class AppItem extends StatelessWidget {
  final AppModel app;
  final VoidCallback onTap;

  const AppItem({super.key, required this.app, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero, // Let GridView spacing handle margins
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16), // More padding for breathing space
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: app.color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(app.icon, size: 28, color: app.color),
              ),
              const SizedBox(height: 12),
              Text(
                app.title,
                style: const TextStyle(
                  fontSize: 16, // Larger text
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                app.description,
                style: TextStyle(
                  fontSize: 14, // Larger description text
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 2, // Now fits better with 2 lines
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
