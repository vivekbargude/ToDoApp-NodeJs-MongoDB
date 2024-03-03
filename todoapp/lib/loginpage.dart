import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todoapp/commonlogo.dart';
import 'package:todoapp/config.dart';
import 'package:todoapp/dashboard.dart';
import 'package:todoapp/registration.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  late SharedPreferences prefs;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text
      };

      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['success']) {
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DashBoard(token: myToken)));
      } else {
        print('Something went wrong');
      }
    }
    else{
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 64, 196, 255), Color.fromARGB(255, 64, 196, 255)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomCenter,
                stops: [0.0, 0.8],
                tileMode: TileMode.mirror),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CommonLogo(),
                  const HeightBox(10),
                  "SIGN IN".text.size(22).bold.black.make(),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email,color: Colors.black,),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Email",
                        errorStyle: const TextStyle(color: Colors.black),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock,color: Colors.black,),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Password",
                      errorStyle: const TextStyle(color: Colors.black),
                      errorText: _isNotValidate ? "Enter Proper Info" : null,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ).p4().px24(),
                  Padding(
                    padding: const EdgeInsets.only(top:20),
                    child: GestureDetector(
                      onTap: () {
                        loginUser();
                      },
                      child: HStack([
                        VxBox(child: "LogIn".text.bold.white.makeCentered().p1())
                            .green600
                            .roundedLg
                            .width(context.percentWidth * 80) 
                            .height(50)
                            .make(),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
             onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => const Registration()));
             },
          child: Container(
              height: 60,
              color:Color.fromARGB(255, 64, 196, 255),
              child: Center(
                  child: "Create a new Account..! Sign Up".text.black.makeCentered(),)
                  ),
        ),
      ),
    );
  }
}
