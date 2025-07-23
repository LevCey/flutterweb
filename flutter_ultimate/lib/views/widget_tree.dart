import 'package:flutte_ultimate/data/constants.dart';
import 'package:flutte_ultimate/data/riverpod_notifiers.dart';
import 'package:flutte_ultimate/views/pages/home_page.dart';
import 'package:flutte_ultimate/views/pages/profile_page.dart';
import 'package:flutte_ultimate/views/pages/settings_page.dart';
import 'package:flutte_ultimate/views/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Widget> pages = [HomePage(), ProfilePage()];

class WidgetTree extends ConsumerWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Levent Web App'),
        actions: [
          IconButton(
            onPressed: () async {
              ref.read(isDarkModeProvider.notifier).update((state) => !state);

              // Save the theme mode to SharedPreferences
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setBool(
                KConstants.themeModeKey,
                ref.read(isDarkModeProvider),
              );
            },
            icon: Icon(
              ref.watch(isDarkModeProvider)
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(title: 'Settings'),
                ),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: pages.elementAt(ref.watch(selectedPageProvider)),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
