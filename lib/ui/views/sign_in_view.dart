import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymanager/core/services/AuthServices.dart';
import 'package:moneymanager/ui/views/register_view.dart';

import 'forgot_password_view.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignInScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> avoidReturnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text("vous etes sur de sortir ?"),
            actions: [Negative(context), Positive()],
          );
        });
    return true;
  }

  Widget Positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: const Text(
            " Oui",
            style: TextStyle(
              color: Color(0xffEAEDEF),
            ),
          )),
    );
  } // fermeture de l'application

  Widget Negative(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context); // fermeture de dialog
        },
        child: Text(" Non"));
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: avoidReturnButton,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
                key: _formkey,
                child: Column(children: [
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(90),
                      ),
                      gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                        Colors.blueGrey,
                        Colors.indigo,
                      ]),
                    ),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Image(
                            image: AssetImage('assets/icons/logo.png'),
                            height: 100,
                            width: 100,
                          ),
                        ),
                        // SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            'Money Manager ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                //  fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        )
                      ],
                    )),
                  ),
                  SizedBox(height: 80),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 6),
                      ),
                    ]),
                    height: 50,
                    child: TextFormField(
                      controller: emailController,
                      validator: (Value) {
                        if (Value!.isEmpty) return "s'il vous plait saisir un email valide ";
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14),
                        prefixIcon: Icon(Icons.email, color: Colors.indigo),
                        hintText: 'exemple@gmail.com',
                        hintStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 6),
                      ),
                    ]),
                    height: 50,
                    child: TextFormField(
                      controller: passwordController,
                      validator: (Value) {
                        if (Value!.isEmpty) return "s'il vous plait saisir un mot de passe valide ";
                      },
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.indigo,
                        ),
                        hintText: 'Mot de passe',
                        hintStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(ForgotPassScreen());
                      },
                      child: Text(
                        "mot de passe oublié?",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black54,
                            //fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? CircularProgressIndicator()
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                  child: CupertinoButton(
                                      child:
                                          Text('Connexion', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
                                      color: Colors.indigo,
                                      onPressed: () {
                                        if (_formkey.currentState!.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          AuthServices()
                                              .signIn(emailController.text, passwordController.text)
                                              .then((value) async {
                                            if (value) {
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                              });
                                            }
                                          });
                                        }
                                      }))
                            ],
                          )),
                  SizedBox(height: 20),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextButton(
                            child: Text("Besoin d'un nouveau compte?",
                                style: TextStyle(color: Colors.indigo, fontSize: 14, fontStyle: FontStyle.italic)),
                            onPressed: () {
                              Get.to(SignupScreen());
                            },
                          ))
                        ],
                      )),
                ])),
          )),
    );
  }
}
