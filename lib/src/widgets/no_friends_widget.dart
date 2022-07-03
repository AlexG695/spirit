import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class NoFriendsWidget extends StatelessWidget {

  String text;
  NoFriendsWidget({Key key, this.text}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 65),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _lottieAnimation(),
          Text(
              text,
            style: const TextStyle(
              fontFamily: 'Glegoo',
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
}

Widget _lottieAnimation(){
  return Container(
    margin: const EdgeInsets.only(
      top: 5,
    ),
    child: Lottie.asset('src/json/amigos.json',
        width: 280,
        height: 280,
        fit: BoxFit.fill
    ),
  );

  
}
