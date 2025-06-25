import 'package:flutte_ultimate/views/widgets/container_widget.dart';
import 'package:flutte_ultimate/views/widgets/hero_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            HeroWidget(title: 'Levent Webapp'),
            ...List.generate(3, (index) {
              // ... listenin kendini değil içindeki widgetleri tek tek çıkarır.
              return ContainerWidget(
                title: 'Basic Layout',
                description: 'The description of this',
              );
            }),
          ],
        ),
      ),
    );
  }
}
