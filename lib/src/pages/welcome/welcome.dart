import 'package:flutter/material.dart';
import 'package:integradora/src/utils/mycolors.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 10),
        _lottieAnimationWelcome(),
        _text(),
        SizedBox(height: 20),
        _buttons()
      ],
    ));
  }

  Widget _lottieAnimationWelcome() {
    return Container(
      child: Lottie.asset('assets/json/amigos.json'),
      height: 170,
      width: 150,
    );
  }

  Widget _text() {
    return Container(
      child: Text(
          'Bienvenido a Rescue, inicia sesión o crea una cuenta para continuar',
          style: TextStyle(
              fontFamily: 'Roboto', fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buttons() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
          child: ElevatedButton(
            onPressed: goLogin,
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                primary: MyColors.primaryColor),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 35, top: 5),
                    height: 30,
                    child: Icon(
                      Icons.arrow_circle_right_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 25),
        Text(
          '-o-',
          style: TextStyle(
              fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 25),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
          child: ElevatedButton(
            onPressed: goRegistro,
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                primary: MyColors.primaryColor),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      'Crear una cuenta',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 35, top: 5),
                    height: 30,
                    child: Icon(
                      Icons.arrow_circle_right_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void goRegistro() {
    Navigator.pushNamed(context, 'register');
  }

  void goLogin() {
    Navigator.pushNamed(context, 'login');
  }
}
