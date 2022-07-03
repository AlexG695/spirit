import 'package:flutter/material.dart';
import 'package:integradora/src/pages/usuario/perfil/perfil_controller.dart';
import 'package:integradora/src/utils/mycolors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PerfilController _con = PerfilController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil de ')),
      bottomNavigationBar: _buttonUpdateInfo(),
    );
  }

  Widget _buttonUpdateInfo() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.update,
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
                  'Actualizar mi información',
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
                  Icons.save,
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
}
