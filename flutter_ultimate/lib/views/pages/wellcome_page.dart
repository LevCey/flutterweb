import 'package:flutte_ultimate/views/pages/login_page.dart';
import 'package:flutte_ultimate/views/pages/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WellcomePage extends StatefulWidget {
  const WellcomePage({super.key});

  @override
  State<WellcomePage> createState() => _WellcomePageState();
}

class _WellcomePageState extends State<WellcomePage>
    with SingleTickerProviderStateMixin {
  // Lottie animasyon kontrolcüsü
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Animasyonu başlatmak için bir kontrolcüye ihtiyacımız var.
    _controller = AnimationController(vsync: this);

    // Animasyonu önceden yüklemek için addListener kullanabiliriz.
    // Ancak en basit yöntem, Lottie.asset'in otomatik olarak yapmasına izin vermektir.
    // Sadece kontrolcü ile yönetmek de bir çözüm olabilir.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Burada animasyonu yüklerken kontrolcü kullanıyoruz
                Lottie.asset(
                  'assets/lotties/wave.json',
                  height: 400.0,
                  // Animasyon tamamlandığında yapılacak bir işlem varsa onLoaded kullanın.
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
                FittedBox(
                  child: Text(
                    'Flutter Web App',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      letterSpacing: 5,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                FilledButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => OnboardingPage()),
                    );
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: Size(double.infinity, 40.0),
                  ),
                  child: Text('Get Started'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(title: 'Login'),
                      ),
                    );
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
