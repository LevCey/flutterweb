import 'package:flutte_ultimate/views/pages/expanded_flexible_page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController controller = TextEditingController();
  bool? isChecked = false;
  bool isSwitched = false;
  double sliderValue = 0.0;
  String? menuItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          onPressed: () {
            // Kitap yığını benzetmesine dönersek,
            // en üstteki kitabı alır ve alttaki kitap tekrar görünür hale gelir.
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Snackbar'),
                      duration: Duration(seconds: 1),
                      behavior: SnackBarBehavior.fixed,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                child: Text('Click for Snackbar'),
              ),
              Divider(color: Colors.teal, thickness: 5.0, endIndent: 200),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Alert Title'),
                        content: Text('Alert Dialog'),
                        actions: [
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade300,
                  foregroundColor: Colors.white,
                ),
                child: Text('Open Dialog'),
              ),
              DropdownButton(
                style: TextStyle(color: Colors.teal),
                focusColor: Colors.tealAccent,
                hint: Text('Element'),
                value: menuItem,
                items: [
                  DropdownMenuItem(value: 'el1', child: Text('Element1')),
                  DropdownMenuItem(value: 'el2', child: Text('Element2')),
                  DropdownMenuItem(value: 'el3', child: Text('Element3')),
                ],
                onChanged: (value) {
                  setState(() {
                    menuItem = value;
                  });
                },
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(border: OutlineInputBorder()),
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              Text(controller.text),
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('click me'),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
              Switch(
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
              SwitchListTile.adaptive(
                title: Text('Switch me'),
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
              Slider(
                max: 10,
                divisions: 10,
                value: sliderValue,
                onChanged: (double value) {
                  setState(() {
                    sliderValue = value;
                    // print(value);
                  });
                },
              ),
              InkWell(
                splashColor: Colors.teal.shade300,
                hoverColor: Colors.tealAccent,
                onTap: () {
                  // print('image selected');
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.black54,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    (context),
                    MaterialPageRoute(
                      builder: (context) => ExpandedFlexiblePage(),
                    ),
                  );
                },
                child: Text('Show flexible and expanded'),
              ),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(foregroundColor: Colors.white),
                child: Text('Click me'),
              ),
              TextButton(onPressed: () {}, child: Text('Click me')),
              OutlinedButton(onPressed: () {}, child: Text('Click me')),
              CloseButton(),
              BackButton(),
            ],
          ),
        ),
      ),
    );
  }
}
