import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:integradora/src/pages/login/login_controller.dart';
import 'package:integradora/src/utils/mycolors.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isHiden = true;

  LoginController _con = LoginController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Init state');

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(top: -80, left: -100, child: _circleLogin()),
          Positioned(
            child: _textLogin(),
            top: 65,
            left: 13,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                _textWelcome(),
                /*Image.asset(
                  'assets/img/icono_rescue.png',
                  height: 250,
                  width: 250,
                ),*/
                //_imageBanner(),
                _lottieAnimation(),
                _textFieldEmail(),
                _textFieldPassword(),
                _buttonLogin(),
                //_textDontHaveAccount()
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _lottieAnimation() {
    return Container(
      margin: EdgeInsets.only(
          top: 70, bottom: MediaQuery.of(context).size.height * 0.02),
      child: Lottie.asset('assets/json/corona_woman.json',
          width: 350, height: 300, fit: BoxFit.fill),
    );
  }

  Widget _textLogin() {
    return Text(
      'Inicia sesión',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'Glegoo'),
    );
  }
/*
  Widget _textDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes cuenta?',
          style: TextStyle(color: MyColors.primaryColor, fontSize: 17),
        ),
        SizedBox(width: 7),
        GestureDetector(
          onTap: _con.goToRegisterPage,
          child: Text('Cree una',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyColors.primaryColor,
                  fontSize: 17)),
        ),
      ],
    );
  }*/

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.login,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            primary: MyColors.primaryColor),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  'Ingresar',
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
                  Icons.arrow_right_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryDegreeColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.passwordController,
        obscureText: _isHiden,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            prefixIcon: Icon(
              Icons.lock,
              color: MyColors.primaryColor,
            ),
            suffixIcon: InkWell(
              onTap: _tooglePasswordView,
              child: Icon(
                _isHiden ? Icons.visibility : Icons.visibility_off,
                color: MyColors.primaryColor,
              ),
            )),
      ),
    );
  }

  void _tooglePasswordView() {
    setState(() {
      _isHiden = !_isHiden;
    });
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryDegreeColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            prefixIcon: Icon(
              Icons.alternate_email,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _circleLogin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.primaryColor),
    );
  }

  /*Widget _imageBanner() {
    return Container(
      margin: EdgeInsets.only(
          top: 65,
          bottom: MediaQuery.of(context).size.height * 0.125
      ),
      child: Image.asset(
        'assets/img/icono Six Fory-Eit.png',
        width: 200,
        height: 200,
      )
    );
  }*/

  Widget _textWelcome() {
    return Container(
      margin: EdgeInsets.only(top: 165),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Bienvenido a',
            style: TextStyle(fontSize: 28),
          ),
          SizedBox(width: 7),
          Container(
            child: Text('Rescue',
                style: TextStyle(color: MyColors.primaryColor, fontSize: 28)),
          ),
        ],
      ),
    );
  }
}
