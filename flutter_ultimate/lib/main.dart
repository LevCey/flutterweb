import 'package:flutte_ultimate/data/constants.dart';
import 'package:flutte_ultimate/data/riverpod_notifiers.dart';
import 'package:flutte_ultimate/views/pages/wellcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    initThemeMode();
  }

  void initThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ref.read(isDarkModeProvider.notifier).state =
        prefs.getBool(KConstants.themeModeKey) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Levent Dapp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: ref.watch(isDarkModeProvider)
              ? Brightness.dark
              : Brightness.light,
        ),
      ),
      home: WellcomePage(),
    );
  }
}
