import 'package:flutte_ultimate/data/constants.dart';
import 'package:flutte_ultimate/views/pages/login_page.dart';
import 'package:flutte_ultimate/views/pages/wellcome_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
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
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WellcomePage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lotties/hi.json',
                  height: 400.0,
                  // Animasyon tamamlandığında yapılacak bir işlem varsa onLoaded kullanın.
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
                SizedBox(height: 20),
                FittedBox(
                  child: Text(
                    'Flutter is the best way to develop mobile app',
                    style: KTextStyle.descriptionText,
                    textAlign: TextAlign.justify,
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      (context),
                      MaterialPageRoute(
                        builder: (context) => LoginPage(title: 'Register'),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: Size(
                      maxWidth < 500 ? 100 : maxWidth * 0.5,
                      40.0,
                    ),
                  ),
                  child: Text('Next'),
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
