import 'package:flutter/material.dart';
import 'package:integradora/src/pages/usuario/contacts/contact_controller.dart';
import 'package:integradora/src/utils/mycolors.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key key}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  ContactController _con = ContactController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Añadir un nuevo contacto de confianza')),
      bottomNavigationBar: _saveContact(),
    );
  }

  Widget _saveContact() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: () {},
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
                  'Agregar contacto de confianza',
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
