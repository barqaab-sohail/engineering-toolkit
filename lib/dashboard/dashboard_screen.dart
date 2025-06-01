import 'package:flutter/material.dart';
import '../apps/apps_list.dart';
import 'app_item.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Engineering Toolkit'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Changed from 3 to 2
          childAspectRatio: 0.9, // Wider items (0.7-1.2 range works best)
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: appsList.length,
        itemBuilder: (context, index) {
          return AppItem(
            app: appsList[index],
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => appsList[index].screen,
                  ),
                ),
          );
        },
      ),
    );
  }
}
