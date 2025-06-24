import 'package:flutte_ultimate/data/constants.dart';
import 'package:flutte_ultimate/views/widget_tree.dart';
import 'package:flutte_ultimate/views/widgets/hero_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WellcomePage extends StatelessWidget {
  const WellcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/home.json'),
            FittedBox(
              child: Text(
                'Flutter Web App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  letterSpacing: 50,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            FilledButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WidgetTree()),
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
                  MaterialPageRoute(builder: (context) => WidgetTree()),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
