import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:integradora/src/pages/register/register_controller.dart';
import 'package:integradora/src/utils/mycolors.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isHiden = true;
  bool _isHiden2 = true;

  RegisterController _con = new RegisterController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(top: -80, left: -100, child: _circle()),
                Positioned(
                  child: _textRegister(),
                  top: 63,
                  left: 28,
                ),
                Positioned(
                  child: _iconBack(),
                  top: 50,
                  left: -4,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 150),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      _imageUser(),
                      SizedBox(height: 4),
                      _textFieldEmail(),
                      _textFieldName(),
                      _textFieldLastName(),
                      _textFieldPhone(),
                      _textFieldPassword(),
                      _textFieldConfirmPassword(),
                      _buttonLogin()
                    ]),
                  ),
                )
              ],
            )));
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
              Icons.email,
              color: MyColors.black,
            )),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryDegreeColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.black,
            )),
      ),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryDegreeColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.lastnameController,
        decoration: InputDecoration(
            hintText: 'Apellido',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            prefixIcon: Icon(
              Icons.person_outline,
              color: MyColors.black,
            )),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryDegreeColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Telefono',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColor),
            prefixIcon: Icon(
              Icons.phone,
              color: MyColors.black,
            )),
      ),
    );
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
                color: MyColors.black,
              ),
              suffixIcon: InkWell(
                onTap: _tooglePasswordView,
                child: Icon(
                  _isHiden ? Icons.visibility : Icons.visibility_off,
                  color: MyColors.black,
                ),
              ),
            )));
  }

  Widget _textFieldConfirmPassword() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        decoration: BoxDecoration(
            color: MyColors.primaryDegreeColor,
            borderRadius: BorderRadius.circular(30)),
        child: TextField(
            controller: _con.confirmpasswordController,
            obscureText: _isHiden2,
            decoration: InputDecoration(
              hintText: 'Confirmar contraseña',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
              hintStyle: TextStyle(color: MyColors.primaryColor),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: MyColors.black,
              ),
              suffixIcon: InkWell(
                onTap: _tooglePasswordView2,
                child: Icon(
                  _isHiden2 ? Icons.visibility : Icons.visibility_off,
                  color: MyColors.black,
                ),
              ),
            )));
  }

  void _tooglePasswordView() {
    setState(() {
      _isHiden = !_isHiden;
    });
  }

  void _tooglePasswordView2() {
    setState(() {
      _isHiden2 = !_isHiden2;
    });
  }

  Widget _imageUser() {
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: _con.imageFile != null
            ? FileImage(_con.imageFile)
            : AssetImage('assets/img/user_profile.png'),
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Widget _iconBack() {
    return IconButton(
        onPressed: _con.back,
        icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 22));
  }

  Widget _textRegister() {
    return Text(
      'Registro',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: 'Glegoo'),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.isEnabled ? _con.register : null,
        child: Text('Registrar'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _circle() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.primaryColor),
    );
  }

  void refresh() {
    setState(() {});
  }
}
