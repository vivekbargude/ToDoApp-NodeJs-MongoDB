
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CommonLogo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network("https://pluspng.com/img-png/avengers-logo-png-avengers-logo-png-1376.png",width: 100,color: Colors.black,),
        "To-Do App".text.black.xl2.italic.make(),
        "Make A List of your task".text.light.black.wider.lg.make(),
      ],
    );
  }
}