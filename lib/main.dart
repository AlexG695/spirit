import 'package:flutter/material.dart';
import 'package:integradora/src/pages/usuario/contacts/contact.dart';
import 'package:integradora/src/pages/usuario/inicio/home.dart';
import 'package:integradora/src/pages/login/login_page.dart';
import 'package:integradora/src/pages/register/register.dart';
import 'package:integradora/src/pages/splashScreen/SplashScreen.dart';
import 'package:integradora/src/pages/support/support.dart';
import 'package:integradora/src/pages/usuario/friends/friends.dart';
import 'package:integradora/src/pages/usuario/perfil/perfil.dart';
import 'package:integradora/src/pages/welcome/welcome.dart';
import 'package:integradora/src/utils/mycolors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rescue',
      debugShowCheckedModeBanner: false,
      initialRoute: 'splashScreen',
      routes: {
        'splashScreen': (BuildContext context) => SplashScreen(),
        'login': (BuildContext context) => Login(),
        'register': (BuildContext context) => RegisterPage(),
        'usuario/inicio/home': (BuildContext context) => HomePage(),
        'usuario/friends': (BuildContext context) => Friends(),
        'support': (BuildContext context) => Support(),
        'profile': (BuildContext context) => ProfilePage(),
        'welcome': (BuildContext context) => Welcome(),
        'addcontact': (BuildContext context) => AddContact()
      },
      theme: ThemeData(
          primaryColor: MyColors.primaryColor,
          appBarTheme: const AppBarTheme(elevation: 0)),
      darkTheme: ThemeData.dark(),
    );
  }
}
