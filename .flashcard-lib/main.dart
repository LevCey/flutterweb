import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// firebase_options.dart dosyası `flutterfire configure` komutu ile otomatik oluşur.
import 'firebase_options.dart';

void main() async {
  //flutter uygulamasını başlatmadan önce firebase'i başlat
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase başariyla başlatildi');
  } catch (e) {
    print('Firabase başlatilirken bir hata oluştu: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bilgi Kartları',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
      ),
      home: const FlashcardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  // Firebase Realtime Database referansını alıyoruz.
  // Bu, 'flashcards' adında bir ana dalı temsil edecek.

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
