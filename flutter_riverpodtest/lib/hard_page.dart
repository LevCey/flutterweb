import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpodtest/riverpod.dart';

class HardPage extends ConsumerWidget {
  const HardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade100,
        title: const Text(
          'HARD PAGE',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5.0,
          children: [
            Text(
              ref.watch(hardLevelProvider).toString(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(hardLevelProvider.notifier).increment();
              },
              icon: Icon(Icons.add, color: Colors.deepPurple.shade300),
              label: const Text(
                'Add',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(hardLevelProvider.notifier).decrement();
              },
              icon: Icon(Icons.remove, color: Colors.deepPurple.shade300),
              label: const Text(
                'Remove',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        ),
      ),
    ); // Burayı kendi widget'ınızla değiştirin
  }
}
