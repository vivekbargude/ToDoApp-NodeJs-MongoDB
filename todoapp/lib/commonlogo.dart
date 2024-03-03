
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CommonLogo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/logo.png",width: 100,
          ),
        "TaskMate".text.black.xl2.bold.make(),
        Padding(
          padding: const EdgeInsets.only(top : 8.0),
          child: "Make A List of your task".text.light.black.wider.lg.make(),
        ),
      ],
    );
  }
}