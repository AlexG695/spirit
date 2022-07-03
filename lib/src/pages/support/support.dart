import 'package:flutter/material.dart';

class Support extends StatefulWidget {
  Support({Key key}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Soporte'
        ),
      )
    );
  }
}