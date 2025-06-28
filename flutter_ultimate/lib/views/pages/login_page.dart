import 'package:flutte_ultimate/views/pages/wellcome_page.dart';
import 'package:flutte_ultimate/views/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  // Lottie animasyon kontrolcüsü
  late final AnimationController _controller;

  TextEditingController controllerEmail = TextEditingController(text: '123');
  TextEditingController controllerPw = TextEditingController(text: '456');

  String confirmedEmail = '123';
  String confirmedPw = '456';

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
    controllerEmail.dispose();
    controllerPw.dispose();
    _controller.dispose();
    // Kontrolcüyü dispose etmeden önce, animasyonun durdurulması önemlidir.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double widthScreen = MediaQuery.of(context).size.width;
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
            child: LayoutBuilder(
              builder: (context, BoxConstraints constraints) {
                return FractionallySizedBox(
                  widthFactor: constraints.maxWidth > 500 ? 0.7 : 1.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/lotties/home.json',
                        height:
                            250.0, // Animasyon tamamlandığında yapılacak bir işlem varsa onLoaded kullanın.
                        onLoaded: (composition) {
                          _controller
                            ..duration = composition.duration
                            ..forward();
                        },
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: controllerEmail,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hint: Text('E-mail'),
                        ),
                        onEditingComplete: () {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: controllerPw,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hint: Text('Password'),
                        ),
                        onEditingComplete: () {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 20.0),
                      FilledButton(
                        onPressed: () {
                          onLoginPressed();
                        },
                        style: FilledButton.styleFrom(
                          minimumSize: Size(double.infinity, 40.0),
                        ),
                        child: Text(widget.title),
                      ),
                      SizedBox(height: 50.0),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void onLoginPressed() {
    if (confirmedEmail == controllerEmail.text &&
        confirmedPw == controllerPw.text) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WidgetTree();
          },
        ),
      );
    }
  }
}
