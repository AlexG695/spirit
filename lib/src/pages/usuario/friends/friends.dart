import 'package:flutter/material.dart';
import 'package:integradora/src/pages/usuario/friends/friends_controller.dart';
import 'package:integradora/src/widgets/no_friends_widget.dart';
import 'package:lottie/lottie.dart';

class Friends extends StatefulWidget {
  const Friends({Key key}) : super(key: key);

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  FriendsController _con = FriendsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            child: Icon(Icons.contacts_sharp),
            onTap: null,
          ),
        ],
        title: const Text('Mis contactos',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                fontFamily: 'Roboto')),
      ),
      body: NoFriendsWidget(
        text: 'Oh no, aún no tienes contactos de confianza',
      ),
    );
  }

  void addContact() {
    Navigator.pushNamed(context, 'addcontact');
  }

  void refresh() {
    setState(() {});
  }
}
