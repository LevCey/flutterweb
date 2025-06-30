import 'package:flutte_ultimate/data/riverpod_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavbarWidget extends ConsumerWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationBar(
      destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      ],
      onDestinationSelected: (int value) {
        ref.read(selectedPageProvider.notifier).setPage(value);
      },
      selectedIndex: ref.watch(selectedPageProvider),
    );
  }
}
