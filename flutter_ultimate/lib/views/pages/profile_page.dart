import 'package:flutte_ultimate/data/riverpod_notifiers.dart';
import 'package:flutte_ultimate/views/pages/wellcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              ref.read(selectedPageProvider.notifier).setPage(0);
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
