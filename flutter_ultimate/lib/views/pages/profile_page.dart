import 'package:flutte_ultimate/data/notifiers.dart';
import 'package:flutte_ultimate/views/pages/wellcome_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              selectedPageNotifier.value = 0;
              Navigator.pushReplacement(
                (context),
                MaterialPageRoute(builder: (context) => WellcomePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
