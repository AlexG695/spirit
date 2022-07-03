import 'package:flutter/material.dart';
import 'package:integradora/src/pages/welcome/welcome.dart';
import 'package:integradora/src/utils/mycolors.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Future.delayed(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Welcome())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Center(
              child: FractionallySizedBox(
                widthFactor: .4,
              ),
            ),
            const SizedBox(height: 175),
            Image.asset(
              'assets/img/icono_rescue.png',
              height: 250,
              width: 250,
            ),
            const SizedBox(height: 25),
            const Text(
              'Rescue',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Glegoo',
                  fontSize: 28,
                  color: Colors.black),
            ),
            const SizedBox(height: 7),
            const Text(
              'de Seek & Develop',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Glegoo',
                  fontSize: 16,
                  color: Colors.black),
            ),
            /*_lottieAnimation(),
            CircularProgressIndicator(
              color: Colors.black,
            ),*/
          ],
        ),
      ),
    );
  }
}
