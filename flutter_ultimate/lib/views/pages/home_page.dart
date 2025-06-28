import 'package:flutte_ultimate/data/constants.dart';
import 'package:flutte_ultimate/views/pages/course_page.dart';
import 'package:flutte_ultimate/views/widgets/container_widget.dart';
import 'package:flutte_ultimate/views/widgets/hero_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      KValue.basicLayout,
      KValue.cleanUI,
      KValue.fixBugs,
      KValue.keyConcepts,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.0),
            HeroWidget(title: 'Levent Web App', nextPage: CoursePage()),
            ...List.generate(list.length, (index) {
              return ContainerWidget(
                title: list.elementAt(index),
                description: 'The Description of This...',
              );
            }),
          ],
        ),
      ),
    );
  }
}
